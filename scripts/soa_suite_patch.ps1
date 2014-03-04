$AppProps = Get-Content ../wls.properties -Raw | convertfrom-stringdata 

# environment vars
$env:JAVA_HOME = "$($AppProps.java_home)"
$env:path = $env:path + ";$($AppProps.java_home)\bin"

# unzip patch
iex "cd $($AppProps.main_location)/temp"
jar xf "$($AppProps.main_location)/binaries/p17584181_111170_Generic.zip"

# apply soa suite opatch
iex "$($AppProps.mdw_dir)/Oracle_SOA1/OPatch/opatch apply -silent -jdk $($AppProps.java_home) -jre $($AppProps.java_home)  -oh $($AppProps.mdw_dir)/Oracle_SOA1 $($AppProps.main_location)/temp/17584181"

cd "$($AppProps.main_location)/scripts"
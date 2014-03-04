$AppProps = Get-Content ../wls.properties -Raw | convertfrom-stringdata 

# environment vars
$env:JAVA_HOME = "$($AppProps.java_home)"
$env:path = $env:path + ";$($AppProps.java_home)\bin"

# unzip the SOA SUITE software
iex "mkdir $($AppProps.main_location)/temp/soa -ErrorAction SilentlyContinue"
iex "cd $($AppProps.main_location)/temp/soa"
jar xf "$($AppProps.main_location)/binaries/ofm_soa_generic_11.1.1.7.0_disk1_1of2.zip"
jar xf "$($AppProps.main_location)/binaries/ofm_soa_generic_11.1.1.7.0_disk1_2of2.zip"

# copy silent response file and add SOA Suite home to the template
iex "(Get-Content $($AppProps.main_location)/templates/fmw_silent_soa.rsp).replace('--MDW_HOME--', '$($AppProps.mdw_dir)')  |  Out-File $($AppProps.main_location)/temp/fmw_silent_soa.rsp -Encoding ASCII -Force"

# install SOA
iex "$($AppProps.main_location)/temp/soa/Disk1/setup.exe -silent -response $($AppProps.main_location)/temp/fmw_silent_soa.rsp -waitforcompletion -ignoreSysPrereqs -jreLoc $($AppProps.java_home)"

cd "$($AppProps.main_location)/scripts"
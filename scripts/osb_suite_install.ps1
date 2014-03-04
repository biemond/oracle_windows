$AppProps = Get-Content ../wls.properties -Raw | convertfrom-stringdata 

# environment vars
$env:JAVA_HOME = "$($AppProps.java_home)"
$env:path = $env:path + ";$($AppProps.java_home)\bin"

# unzip the OSB software
iex "mkdir $($AppProps.main_location)/temp/osb -ErrorAction SilentlyContinue"
iex "cd $($AppProps.main_location)/temp/osb"
jar xf "$($AppProps.main_location)/binaries/ofm_osb_generic_11.1.1.7.0_disk1_1of1.zip"

# copy silent response file and add OSB home to the template
iex "(Get-Content $($AppProps.main_location)/templates/fmw_silent_osb.rsp).replace('--MDW_HOME--', '$($AppProps.mdw_dir)')  |  Out-File $($AppProps.main_location)/temp/fmw_silent_osb.rsp  -Encoding ASCII -Force"

# install OSB
iex "$($AppProps.main_location)/temp/osb/Disk1/setup.exe -silent -response $($AppProps.main_location)/temp/fmw_silent_osb.rsp -waitforcompletion -ignoreSysPrereqs -jreLoc $($AppProps.java_home)"

cd "$($AppProps.main_location)/scripts"
$AppProps = Get-Content ../wls.properties -Raw | convertfrom-stringdata 

# create oracle folders
mkdir $AppProps.log_dir -ErrorAction SilentlyContinue
mkdir $AppProps.inv_dir -ErrorAction SilentlyContinue
mkdir $AppProps.app_dir -ErrorAction SilentlyContinue
mkdir $AppProps.dom_dir -ErrorAction SilentlyContinue
mkdir $AppProps.mdw_dir -ErrorAction SilentlyContinue

# environment vars
$env:JAVA_HOME = "$($AppProps.java_home)"
$env:path = $env:path + ";$($AppProps.java_home)\bin"

# copy silent xml and add middleware home to the template
iex "(Get-Content $($AppProps.main_location)/templates/silent_wls.xml).replace('--MDW_HOME--', '$($AppProps.mdw_dir)')  |  Out-File $($AppProps.main_location)/temp/silent_wls.xml -Encoding ASCII -Force"

# install weblogic
iex "java -Xmx1024m -jar $($AppProps.main_location)/binaries/wls1036_generic.jar -mode=silent -silent_xml=$($AppProps.main_location)/temp/silent_wls.xml"

# add ora inventory registry
Md "HKLM:\Software\Oracle\" 
New-ItemProperty "HKLM:\Software\Oracle\" -Name "inst_loc" -Value $AppProps.inventory_dir

$AppProps = Get-Content ../wls.properties -Raw | convertfrom-stringdata 

# create java home folder
mkdir $AppProps.java_home -ErrorAction SilentlyContinue

# go to the binaries folder
#cd  "$($AppProps.main_location)/binaries"

# install java 
iex "$($AppProps.main_location)/binaries/$($AppProps.java_file) /s ADDLOCAL='ToolsFeature' INSTALLDIR=$($AppProps.java_home)"

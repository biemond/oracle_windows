$AppProps = Get-Content ../wls.properties -Raw | convertfrom-stringdata 

# create wls cache folders
mkdir "$($AppProps.mdw_dir)/utils/bsu/cache_dir" -ErrorAction SilentlyContinue

# environment vars
$env:JAVA_HOME = "$($AppProps.java_home)"
$env:path = $env:path + ";$($AppProps.java_home)\bin"

# unzip patch in cachedir
cd "$($AppProps.mdw_dir)/utils/bsu/cache_dir" 
jar xf "$($AppProps.main_location)/binaries/p17572726_1036_Generic.zip"

# go to the bsu folder and start the patch
cd "$($AppProps.mdw_dir)/utils/bsu" 
iex ".\bsu.cmd -install -patchlist=FCX7 -prod_dir=$($AppProps.wl_dir) -verbose"

cd "$($AppProps.main_location)/scripts"
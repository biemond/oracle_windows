mkdir c:\oracle\product\11.1\middleware\utils\bsu\cache_dir
$env:JAVA_HOME = "c:\java\jdk1.7.51"
$env:path = $env:path + ";c:\java\jdk1.7.51\bin"
cd c:\oracle\product\11.1\middleware\utils\bsu\cache_dir
jar xf c:\oracle_windows\binaries\p17572726_1036_Generic.zip

cd c:\oracle\product\11.1\middleware\utils\bsu
.\bsu.cmd -install -patchlist=FCX7 -prod_dir=C:\oracle\product\11.1\middleware\wlserver_10.3 -verbose
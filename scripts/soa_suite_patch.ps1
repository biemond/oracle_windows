$env:JAVA_HOME = "c:\java\jdk1.7.51"
$env:path = $env:path + ";c:\java\jdk1.7.51\bin"
cd c:\oracle_windows\temp
jar xf c:\oracle_windows\binaries\p17584181_111170_Generic.zip
C:\oracle\product\11.1\middleware\Oracle_SOA1\OPatch\opatch apply -silent -jdk c:\java\jdk1.7.51 -jre c:\java\jdk1.7.51\jre  -oh C:\oracle\product\11.1\middleware\Oracle_SOA1 c:\oracle_windows\temp\17584181
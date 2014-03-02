mkdir c:/oracle/logs
mkdir c:/oracle/Inventory
mkdir c:/oracle/weblogic_domains/applications
mkdir c:/oracle/weblogic_domains/domains
mkdir c:/oracle/product/11.1/middleware


$env:JAVA_HOME = "c:\java\jdk1.7.51"
$env:path = $env:path + ";c:\java\jdk1.7.51\bin"
cd /oracle_windows/binaries
java -Xmx1024m -jar wls1036_generic.jar -mode=silent -silent_xml=c:\oracle_windows\templates\silent_wls.xml


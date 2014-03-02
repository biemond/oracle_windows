$env:JAVA_HOME = "c:\java\jdk1.7.51"
$env:path = $env:path + ";c:\java\jdk1.7.51\bin"
mkdir c:\oracle_windows\temp\osb
cd c:\oracle_windows\temp\osb
jar xf c:\oracle_windows\binaries\ofm_osb_generic_11.1.1.7.0_disk1_1of1.zip

C:\oracle_windows\temp\osb\Disk1\setup.exe -silent -response c:/oracle_windows/templates/fmw_silent_osb.rsp -waitforcompletion -ignoreSysPrereqs -jreLoc c:/java/jdk1.7.51

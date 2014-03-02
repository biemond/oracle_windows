$env:JAVA_HOME = "c:\java\jdk1.7.51"
$env:path = $env:path + ";c:\java\jdk1.7.51\bin"
mkdir c:\oracle_windows\temp\soa
cd c:\oracle_windows\temp\soa
jar xf c:\oracle_windows\binaries\ofm_soa_generic_11.1.1.7.0_disk1_1of2.zip
jar xf c:\oracle_windows\binaries\ofm_soa_generic_11.1.1.7.0_disk1_2of2.zip

Md "HKLM:\Software\Oracle\" 
New-ItemProperty "HKLM:\Software\Oracle\" -Name "inst_loc" -Value "C:\\oracle\\Inventory"

C:\oracle_windows\temp\soa\Disk1\setup.exe -silent -response c:/oracle_windows/templates/fmw_silent_soa.rsp -waitforcompletion -ignoreSysPrereqs -jreLoc c:/java/jdk1.7.51

Oracle FMW SOA Suite & OSB install for Windows with powershell
==============================================================

All in silent mode and without a GUI

Oracle FMW structure
- Java home C:\java\jdk1.7.51
- Middleware home C:\oracle\product\11.1\middleware
- log files home C:\oracle\logs
- domains home folder C:\oracle\weblogic_domains\domains 
- Oracle inventory C:\oracle\Inventory

installs
--------
- JDK 1.7v51
- WebLogic 10.3.6 with BSU patch 10.3.6.07
- Oracle SOA Suite 11.1.1.7 with patch 11.1.1.7.2
- Oracle OSB 11.1.1.7
- WebLogic Nodemanager service
- WebLogic Domain with OSB & SOA Suite

WebLogic Domain ( name = wls_osb_soa  in production mode with weblogic1 as password )
- AdminServer 7001
- soa_server1 8001
- bam_server1 9001
- osb_server1 8011
 
 
installation structure
----------------------

Download the following licensed software and add them to the c:\oracle_windows\binaries folder  
c:\oracle_windows\binaries
- jdk-7u51-windows-x64.exe
- ofm_osb_generic_11.1.1.7.0_disk1_1of1.zip
- ofm_soa_generic_11.1.1.7.0_disk1_1of2.zip
- ofm_soa_generic_11.1.1.7.0_disk1_2of2.zip
- p17572726_1036_Generic.zip
- p17584181_111170_Generic.zip
- wls1036_generic.jar

c:\oracle_windows\templates
- silent_wls.xml
- fmw_silent_soa.rsp
- fmw_silent_osb.rsp
- nodemanager.properties

c:\oracle_windows\scripts
- folders.ps1
- java_install.ps1
- weblogic_10.3.6_install.ps1
- weblogic_10.3.6_patch.ps1
- soa_suite_install.ps1
- osb_install.ps1
- soa_suite_patch.ps1

c:\oracle_windows\temp
- empty, used to extract the zip files

Install steps 
-------------

startup powershell.exe  

provide permissions to execute powershell scripts  

     Set-ExecutionPolicy RemoteSigned

and say yes

Execute the following scripts   
- c:\oracle_windows\scripts\java_install.ps1
- c:\oracle_windows\scripts\weblogic_10.3.6_install.ps1
- c:\oracle_windows\scripts\weblogic_10.3.6_patch.ps1
- c:\oracle_windows\scripts\soa_suite_install.ps1
- c:\oracle_windows\scripts\osb_suite_install.ps1
- c:\oracle_windows\scripts\soa_suite_patch.ps1
- c:\oracle_windows\scripts\weblogic_nodemanager.ps1
- c:\oracle_windows\scripts\weblogic_domain.ps1




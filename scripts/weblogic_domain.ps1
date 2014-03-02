C:\oracle\product\11.1\middleware\wlserver_10.3\common\bin\wlst.cmd C:\oracle_windows\templates\domain_osb_soa.py

$username = 'username=weblogic'
$password = 'password=weblogic1'

mkdir C:/oracle/weblogic_domains/domains/wls_osb_soa/servers/AdminServer/security
$username | Set-Content 'C:/oracle/weblogic_domains/domains/wls_osb_soa/servers/AdminServer/security/boot.properties'
$password | Add-Content 'C:/oracle/weblogic_domains/domains/wls_osb_soa/servers/AdminServer/security/boot.properties'

$username | Set-Content 'C:/oracle/weblogic_domains/domains/wls_osb_soa/config/nodemanager/nm_password.properties'
$password | Add-Content 'C:/oracle/weblogic_domains/domains/wls_osb_soa/config/nodemanager/nm_password.properties'

mkdir C:/oracle/weblogic_domains/domains/wls_osb_soa/servers/soa_server1/security
$username | Set-Content 'C:/oracle/weblogic_domains/domains/wls_osb_soa/servers/AdminServer/security/boot.properties'
$password | Add-Content 'C:/oracle/weblogic_domains/domains/wls_osb_soa/servers/AdminServer/security/boot.properties'

mkdir C:/oracle/weblogic_domains/domains/wls_osb_soa/servers/osb_server1/security
$username | Set-Content 'C:/oracle/weblogic_domains/domains/wls_osb_soa/servers/AdminServer/security/boot.properties'
$password | Add-Content 'C:/oracle/weblogic_domains/domains/wls_osb_soa/servers/AdminServer/security/boot.properties'

mkdir C:/oracle/weblogic_domains/domains/wls_osb_soa/servers/bam_server1/security
$username | Set-Content 'C:/oracle/weblogic_domains/domains/wls_osb_soa/servers/AdminServer/security/boot.properties'
$password | Add-Content 'C:/oracle/weblogic_domains/domains/wls_osb_soa/servers/AdminServer/security/boot.properties'

mkdir C:/oracle/weblogic_domains/domains/wls_osb_soa/servers/AdminServer/data/nodemanager
$startup = 'Arguments=-XX\:PermSize\=256m -XX\:MaxPermSize\=512m -Xms1024m -Xmx1024m  -Dweblogic.Stdout\=c\:/oracle/logs/AdminServer.out -Dweblogic.Stderr\=c\:/oracle/logs/AdminServer_err.out' 
$startup | Set-Content 'C:/oracle/weblogic_domains/domains/wls_osb_soa/servers/AdminServer/data/nodemanager/startup.properties'

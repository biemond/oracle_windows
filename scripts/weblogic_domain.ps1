$AppProps = Get-Content ../wls.properties -Raw | convertfrom-stringdata 

# create domain script
iex "(Get-Content $($AppProps.main_location)/templates/domain_osb_soa.py).replace('--MDW_HOME--', '$($AppProps.mdw_dir)').replace('--log_dir--', '$($AppProps.log_dir)').replace('--java_home--', '$($AppProps.java_home)').replace('--app_dir--', '$($AppProps.app_dir)').replace('--dom_dir--', '$($AppProps.dom_dir)').replace('--password--', '$($AppProps.weblogic_password)').replace('--dbprefix--', '$($AppProps.SOA_REPOS_DBUSER_PREFIX)').replace('--dbpassword--', '$($AppProps.SOA_REPOS_DBPASSWORD)').replace('--dburl--', '$($AppProps.SOA_REPOS_DBURL)') | Out-File $($AppProps.main_location)/temp/domain_osb_soa.py -Encoding ASCII -Force"

#Execute WLST script
iex "$($AppProps.wl_dir)/common/bin/wlst.cmd $($AppProps.main_location)/temp/domain_osb_soa.py"

$username = "username=weblogic"
$password = "password=$($AppProps.weblogic_password)"

iex "mkdir $($AppProps.dom_dir)/wls_osb_soa/servers/AdminServer/security -ErrorAction SilentlyContinue"
$username | Set-Content "$($AppProps.dom_dir)/wls_osb_soa/servers/AdminServer/security/boot.properties"
$password | Add-Content "$($AppProps.dom_dir)/wls_osb_soa/servers/AdminServer/security/boot.properties"
$username | Set-Content "$($AppProps.dom_dir)/wls_osb_soa/config/nodemanager/nm_password.properties"
$password | Add-Content "$($AppProps.dom_dir)/wls_osb_soa/config/nodemanager/nm_password.properties"

iex "mkdir $($AppProps.dom_dir)/wls_osb_soa/servers/soa_server1/security -ErrorAction SilentlyContinue"
$username | Set-Content "$($AppProps.dom_dir)/wls_osb_soa/servers/AdminServer/security/boot.properties"
$password | Add-Content "$($AppProps.dom_dir)/wls_osb_soa/servers/AdminServer/security/boot.properties"

iex "mkdir $($AppProps.dom_dir)/wls_osb_soa/servers/osb_server1/security -ErrorAction SilentlyContinue"
$username | Set-Content "$($AppProps.dom_dir)/wls_osb_soa/servers/AdminServer/security/boot.properties"
$password | Add-Content "$($AppProps.dom_dir)/wls_osb_soa/servers/AdminServer/security/boot.properties"

iex "mkdir $($AppProps.dom_dir)/wls_osb_soa/servers/bam_server1/security -ErrorAction SilentlyContinue"
$username | Set-Content "$($AppProps.dom_dir)/wls_osb_soa/servers/AdminServer/security/boot.properties"
$password | Add-Content "$($AppProps.dom_dir)/wls_osb_soa/servers/AdminServer/security/boot.properties"


iex "mkdir $($AppProps.dom_dir)/wls_osb_soa/servers/AdminServer/data/nodemanager -ErrorAction SilentlyContinue"
#$startup = 'Arguments=-XX\:PermSize\=256m -XX\:MaxPermSize\=512m -Xms1024m -Xmx1024m  -Dweblogic.Stdout\=c\:/oracle/logs/AdminServer.out -Dweblogic.Stderr\=c\:/oracle/logs/AdminServer_err.out' 
#$startup | Set-Content 'C:/oracle/weblogic_domains/domains/wls_osb_soa/servers/AdminServer/data/nodemanager/startup.properties'

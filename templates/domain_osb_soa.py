
WLHOME='C:/oracle/product/11.1/middleware/wlserver_10.3'
DOMAIN_PATH='C:/oracle/weblogic_domains/domains/wls_osb_soa'
DOMAIN='wls_osb_soa'
APP_PATH='C:/oracle/weblogic_domains/applications/wls_osb_soa'
DEVELOPMENT_MODE=false
WEBLOGIC_VERSION='10.3.6'
ADMIN_SERVER='AdminServer'
ADMIN_USER='weblogic'
ADMIN_PASSWORD='weblogic1'
JAVA_HOME='C:/java/jdk1.7.51'

ADM_JAVA_ARGUMENTS='-XX:PermSize=256m -XX:MaxPermSize=512m -Xms1024m -Xmx1024m -Dweblogic.Stdout=c:/oracle/logs/AdminServer.out -Dweblogic.Stderr=c:/oracle/logs/AdminServer_err.out'
SOA_JAVA_ARGUMENTS='-XX:PermSize=512m -XX:MaxPermSize=512m -Xms1024m -Xmx1024m -Dweblogic.Stdout=c:/oracle/logs/soa_server1.out -Dweblogic.Stderr=c:/oracle/logs/soa_server1_err.out'
BAM_JAVA_ARGUMENTS='-XX:PermSize=512m -XX:MaxPermSize=512m -Xms1024m -Xmx1024m -Dweblogic.Stdout=c:/oracle/logs/bam_server1.out -Dweblogic.Stderr=c:/oracle/logs/bam_server1_err.out'
OSB_JAVA_ARGUMENTS='-XX:PermSize=512m -XX:MaxPermSize=512m -Xms1024m -Xmx1024m -Dweblogic.Stdout=c:/oracle/logs/osb_server1.out -Dweblogic.Stderr=c:/oracle/logs/osb_server1_err.out'

SOA_REPOS_DBURL='dbserver.alfa.local'
SOA_REPOS_DBUSER_PREFIX='DEV'
SOA_REPOS_DBPASSWORD='Welcome01'

BPM_ENABLED=false
BAM_ENABLED=true

print('Start...wls domain')
readTemplate('C:/oracle/product/11.1/middleware/wlserver_10.3/common/templates/domains/wls.jar')

print('Set crossdomain')
create('base_domain','SecurityConfiguration')
cd('/SecurityConfiguration/base_domain')
set('CrossDomainSecurityEnabled',true)

cd('/')
print('Set domain log')
create('base_domain','Log')
cd('/Log/base_domain')
set('FileName','C:/oracle/logs/'+DOMAIN+'.log')
set('FileCount',10)
set('FileMinSize',5000)
set('RotationType','byTime')
set('FileTimeSpan',24)

cd('/Servers/AdminServer')
# name of adminserver
set('Name',ADMIN_SERVER )

cd('/Servers/'+ADMIN_SERVER)

# address and port
set('ListenPort',7001)

setOption( "AppDir", APP_PATH )

create(ADMIN_SERVER,'ServerStart')
cd('ServerStart/'+ADMIN_SERVER)
set('Arguments', ADM_JAVA_ARGUMENTS)
set('JavaVendor','Sun')
set('JavaHome', JAVA_HOME)

cd('/Server/'+ADMIN_SERVER)
create(ADMIN_SERVER,'SSL')
cd('SSL/'+ADMIN_SERVER)
set('Enabled', 'False')
set('HostNameVerificationIgnored', 'True')

cd('/Server/'+ADMIN_SERVER)
create(ADMIN_SERVER,'Log')
cd('/Server/'+ADMIN_SERVER+'/Log/'+ADMIN_SERVER)
set('FileName','C:/oracle/logs/'+ADMIN_SERVER+'.log')
set('FileCount',10)
set('FileMinSize',5000)
set('RotationType','byTime')
set('FileTimeSpan',24)

print('Set password...')
cd('/')
cd('Security/base_domain/User/weblogic')

# weblogic user name + password
set('Name',ADMIN_USER)
cmo.setPassword(ADMIN_PASSWORD)

# Set domain save options:
# - ServerStartMode: Set mode to development.
# - JavaHome: Sets home directory for the JVM used when starting the server.

if DEVELOPMENT_MODE == true:
  setOption('ServerStartMode', 'dev')
else:
  setOption('ServerStartMode', 'prod')

setOption('JavaHome', JAVA_HOME)

print('write domain...')
# write path + domain name
writeDomain(DOMAIN_PATH)
closeTemplate()

es = encrypt(ADMIN_PASSWORD,DOMAIN_PATH)

readDomain(DOMAIN_PATH)

print('set domain password...') 
cd('/SecurityConfiguration/'+DOMAIN)
set('CredentialEncrypted',es)
print('Set nodemanager password')
set('NodeManagerUsername',ADMIN_USER )
set('NodeManagerPasswordEncrypted',es )

cd('/')

setOption( "AppDir", APP_PATH )

print 'Adding SOA Template'
addTemplate('C:/oracle/product/11.1/middleware/oracle_common/common/templates/applications/oracle.applcore.model.stub.11.1.1_template.jar')
addTemplate('C:/oracle/product/11.1/middleware/oracle_common/common/templates/applications/jrf_template_11.1.1.jar')
addTemplate('C:/oracle/product/11.1/middleware/oracle_common/common/templates/applications/oracle.wsmpm_template_11.1.1.jar')
addTemplate('C:/oracle/product/11.1/middleware/Oracle_SOA1/common/templates/applications/oracle.soa_template_11.1.1.jar')

if BAM_ENABLED == true:
  print 'Adding BAM Template'
  addTemplate('C:/oracle/product/11.1/middleware/Oracle_SOA1/common/templates/applications/oracle.bam_template_11.1.1.jar')

if BPM_ENABLED == true:
  print 'Adding BPM Template'
  addTemplate('C:/oracle/product/11.1/middleware/Oracle_SOA1/common/templates/applications/oracle.bpm_template_11.1.1.jar')

print 'Adding EM Template'
addTemplate('C:/oracle/product/11.1/middleware/oracle_common/common/templates/applications/oracle.em_11_1_1_0_0_template.jar')

dumpStack();

print 'Change datasources'
cd('/JDBCSystemResource/EDNDataSource/JdbcResource/EDNDataSource/JDBCDriverParams/NO_NAME_0')
set('URL',SOA_REPOS_DBURL)
set('PasswordEncrypted',SOA_REPOS_DBPASSWORD)
cd('Properties/NO_NAME_0/Property/user')
set('Value',SOA_REPOS_DBUSER_PREFIX+'_SOAINFRA')

cd('/JDBCSystemResource/EDNLocalTxDataSource/JdbcResource/EDNLocalTxDataSource/JDBCDriverParams/NO_NAME_0')
set('URL',SOA_REPOS_DBURL)
set('PasswordEncrypted',SOA_REPOS_DBPASSWORD)
cd('Properties/NO_NAME_0/Property/user')
set('Value',SOA_REPOS_DBUSER_PREFIX+'_SOAINFRA')

cd('/JDBCSystemResource/OraSDPMDataSource/JdbcResource/OraSDPMDataSource/JDBCDriverParams/NO_NAME_0')
set('URL',SOA_REPOS_DBURL)
set('PasswordEncrypted',SOA_REPOS_DBPASSWORD)
cd('Properties/NO_NAME_0/Property/user')
set('Value',SOA_REPOS_DBUSER_PREFIX+'_ORASDPM')

cd('/JDBCSystemResource/SOADataSource/JdbcResource/SOADataSource/JDBCDriverParams/NO_NAME_0')
set('URL',SOA_REPOS_DBURL)
set('PasswordEncrypted',SOA_REPOS_DBPASSWORD)
cd('Properties/NO_NAME_0/Property/user')
set('Value',SOA_REPOS_DBUSER_PREFIX+'_SOAINFRA')

cd('/JDBCSystemResource/SOALocalTxDataSource/JdbcResource/SOALocalTxDataSource/JDBCDriverParams/NO_NAME_0')
set('URL',SOA_REPOS_DBURL)
set('PasswordEncrypted',SOA_REPOS_DBPASSWORD)
cd('Properties/NO_NAME_0/Property/user')
set('Value',SOA_REPOS_DBUSER_PREFIX+'_SOAINFRA')

cd('/JDBCSystemResource/mds-owsm/JdbcResource/mds-owsm/JDBCDriverParams/NO_NAME_0')
set('URL',SOA_REPOS_DBURL)
set('PasswordEncrypted',SOA_REPOS_DBPASSWORD)
cd('Properties/NO_NAME_0/Property/user')
set('Value',SOA_REPOS_DBUSER_PREFIX+'_MDS')

cd('/JDBCSystemResource/mds-soa/JdbcResource/mds-soa/JDBCDriverParams/NO_NAME_0')
set('URL',SOA_REPOS_DBURL)
set('PasswordEncrypted',SOA_REPOS_DBPASSWORD)
cd('Properties/NO_NAME_0/Property/user')
set('Value',SOA_REPOS_DBUSER_PREFIX+'_MDS')

if BAM_ENABLED == true:
  cd('/JDBCSystemResource/BAMDataSource/JdbcResource/BAMDataSource/JDBCDriverParams/NO_NAME_0')
  set('URL',SOA_REPOS_DBURL)
  set('PasswordEncrypted',SOA_REPOS_DBPASSWORD)
  cd('Properties/NO_NAME_0/Property/user')
  set('Value',SOA_REPOS_DBUSER_PREFIX+'_ORABAM')

updateDomain()
closeDomain();


readDomain(DOMAIN_PATH)

print('change the default machine LocalMachine with type Machine')
cd('/')
cd('Machine/LocalMachine')
create('LocalMachine','NodeManager')
cd('NodeManager/LocalMachine')

print 'Change AdminServer'
cd('/Servers/'+ADMIN_SERVER)
set('Machine','LocalMachine')


print 'Change soa_server1'
setOption( "AppDir", APP_PATH )
cd('/Servers/soa_server1')
set('Machine','LocalMachine')


create('soa_server1','ServerStart')
cd('ServerStart/soa_server1')
set('Arguments', SOA_JAVA_ARGUMENTS)
set('JavaVendor','Sun')
set('JavaHome', JAVA_HOME)

cd('/Server/soa_server1')
create('soa_server1','SSL')
cd('SSL/soa_server1')
set('Enabled', 'False')
set('HostNameVerificationIgnored', 'True')


cd('/Server/soa_server1')
create('soa_server1','Log')
cd('/Server/soa_server1/Log/soa_server1')
set('FileName','C:/oracle/logs/soa_server1.log')
set('FileCount',10)
set('FileMinSize',5000)
set('RotationType','byTime')
set('FileTimeSpan',24)

if BAM_ENABLED == true:
  print 'Change bam_server1'
  cd('/Servers/bam_server1')
  set('Machine','LocalMachine')
  
  create('bam_server1','ServerStart')
  cd('ServerStart/bam_server1')
  set('Arguments', BAM_JAVA_ARGUMENTS)
  set('JavaVendor','Sun')
  set('JavaHome', JAVA_HOME)
  
  cd('/Server/bam_server1')
  create('bam_server1','SSL')
  cd('SSL/bam_server1')
  set('Enabled', 'False')
  set('HostNameVerificationIgnored', 'True')
  
  cd('/Server/bam_server1')
  create('bam_server1','Log')
  cd('/Server/bam_server1/Log/bam_server1')
  set('FileName','C:/oracle/logs/bam_server1.log')
  set('FileCount',10)
  set('FileMinSize',5000)
  set('RotationType','byTime')
  set('FileTimeSpan',24)

dumpStack();
updateDomain()
closeDomain()
# end check


readDomain(DOMAIN_PATH)
setOption( "AppDir", APP_PATH )
print('Extend...osb domain')

addTemplate('C:/oracle/product/11.1/middleware/Oracle_OSB1/common/templates/applications/wlsb.jar')

dumpStack();
updateDomain()

closeDomain();
readDomain(DOMAIN_PATH)

setOption( "AppDir", APP_PATH )

print 'Change osb_server1'
cd('/Servers/osb_server1')
set('Machine','LocalMachine')

create('osb_server1','ServerStart')
cd('ServerStart/osb_server1')
set('Arguments', OSB_JAVA_ARGUMENTS)
set('JavaVendor','Sun')
set('JavaHome', JAVA_HOME)

cd('/Server/osb_server1')
create('osb_server1','SSL')
cd('SSL/osb_server1')
set('Enabled', 'False')
set('HostNameVerificationIgnored', 'True')

cd('/Server/osb_server1')
create('osb_server1','Log')
cd('/Server/osb_server1/Log/osb_server1')
set('FileName','c:/oracle/logs/osb_server1.log')
set('FileCount',10)
set('FileMinSize',5000)
set('RotationType','byTime')
set('FileTimeSpan',24)


cd('/JDBCSystemResource/wlsbjmsrpDataSource/JdbcResource/wlsbjmsrpDataSource/JDBCDriverParams/NO_NAME_0')
set('URL',SOA_REPOS_DBURL)
set('DriverName','oracle.jdbc.OracleDriver')
set('PasswordEncrypted',SOA_REPOS_DBPASSWORD)
cd('Properties/NO_NAME_0/Property/user')
set('Value',SOA_REPOS_DBUSER_PREFIX+'_SOAINFRA')

print 'create opss datasource'
cd('/')
create('opssDataSource', 'JDBCSystemResource')
cd('/JDBCSystemResource/opssDataSource')
if BAM_ENABLED == true:
  set('Target','AdminServer,osb_server1,soa_server1,bam_server1')
else:
  set('Target','AdminServer,osb_server1,soa_server1')
 
 
cd('/JDBCSystemResource/opssDataSource/JdbcResource/opssDataSource')
cmo.setName('opssDataSource')
 
cd('/JDBCSystemResource/opssDataSource/JdbcResource/opssDataSource')
create('myJdbcDataSourceParams','JDBCDataSourceParams')
cd('JDBCDataSourceParams/NO_NAME_0')
set('JNDIName', 'jdbc/opssDataSource')
set('GlobalTransactionsProtocol', 'None')
 
cd('/JDBCSystemResource/opssDataSource/JdbcResource/opssDataSource')
create('myJdbcDriverParams','JDBCDriverParams')
cd('JDBCDriverParams/NO_NAME_0')
set('DriverName','oracle.jdbc.OracleDriver')
set('URL',SOA_REPOS_DBURL)
set('PasswordEncrypted',SOA_REPOS_DBPASSWORD)
set('UseXADataSourceInterface', 'false')
 
create('myProperties','Properties')
cd('Properties/NO_NAME_0')
create('user','Property')
cd('Property')
cd('user')
set('Value', SOA_REPOS_DBUSER_PREFIX+'_OPSS')
 
cd('/JDBCSystemResource/opssDataSource/JdbcResource/opssDataSource')
create('myJdbcConnectionPoolParams','JDBCConnectionPoolParams')
cd('JDBCConnectionPoolParams/NO_NAME_0')
set('TestTableName','SQL SELECT 1 FROM DUAL')

dumpStack();
updateDomain()
closeDomain()

print('Exiting...')
exit()

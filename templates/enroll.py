wlsUser    = 'weblogic'
password   = 'weblogic1'
machine    = 'localhost'
portNumber = '7001'

domain       = 'wls_osb_soa'
domains_path = 'C:/oracle/weblogic_domains/domains'
wlsServer    = 'AdminServer'

domain        = 'wls_osb_soa'
nodeMgrHome   = 'C:/oracle/product/11.1/middleware/wlserver_10.3/common/nodemanager'

connect(wlsUser,password,'t3://'+machine+':'+portNumber)
nmEnroll(domainDir=domains_path+'/'+domain,nmHome=nodeMgrHome)
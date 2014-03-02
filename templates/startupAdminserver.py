# python script wls:wlscontrol

wlsUser    = 'weblogic'
password   = 'weblogic1'
machine    = 'localhost'
portNumber = 5556

domain     = 'wls_osb_soa'
domainPath = 'C:\\oracle\\weblogic_domains\\domains\\wls_osb_soa'
wlsServer  = 'AdminServer'

nmConnect(wlsUser,password,machine,portNumber,domain,domainPath,'ssl')

#start the WlsServer
nmStart(wlsServer)

#Ask the status of the WlsServer
nmServerStatus(wlsServer)

#disconnect from the nodemanager
nmDisconnect()

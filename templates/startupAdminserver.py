# python script wls:wlscontrol

wlsUser    = 'weblogic'
password   = '--password--'
machine    = 'localhost'
portNumber = 5556

domain     = 'wls_osb_soa'
domainPath = '--dom_dir--/wls_osb_soa'
wlsServer  = 'AdminServer'

nmConnect(wlsUser,password,machine,portNumber,domain,domainPath,'ssl')

#start the WlsServer
nmStart(wlsServer)

#Ask the status of the WlsServer
nmServerStatus(wlsServer)

#disconnect from the nodemanager
nmDisconnect()

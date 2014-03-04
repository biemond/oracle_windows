$AppProps = Get-Content ../wls.properties -Raw | convertfrom-stringdata 

# environment vars
$env:JAVA_HOME = "$($AppProps.java_home)"
$env:path = $env:path + ";$($AppProps.java_home)\bin"

# create nodemanager properties
iex "(Get-Content $($AppProps.main_location)/templates/nodemanager.properties).replace('--ndmgr_home--', '$($AppProps.ndmgr_home_dir)').replace('--log_dir--', '$($AppProps.log_dir)').replace('--java_home--', '$($AppProps.java_home)') | Out-File $($AppProps.ndmgr_home_dir)/nodemanager.properties -Encoding ASCII -Force"

# install windows service and start the service 
iex "$($AppProps.wl_dir)/server/bin/installNodeMgrSvc.cmd" 
Start-Service -Name "Oracle WebLogic NodeManager ($($AppProps.ndmgr_service))"
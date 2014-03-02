$env:JAVA_HOME = "c:\java\jdk1.7.51"
$env:path = $env:path + ";c:\java\jdk1.7.51\bin"
cp C:\oracle_windows\templates\nodemanager.properties C:\oracle\product\11.1\middleware\wlserver_10.3\common\nodemanager
C:\oracle\product\11.1\middleware\wlserver_10.3\server\bin\installNodeMgrSvc.cmd
Start-Service -Name "Oracle WebLogic NodeManager (C_oracle_product_11.1_middleware_wlserver_10.3)"
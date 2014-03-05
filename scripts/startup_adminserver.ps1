$AppProps = Get-Content ../wls.properties -Raw | convertfrom-stringdata 

# create adminserver startup script
iex "(Get-Content $($AppProps.main_location)/templates/startupAdminserver.py).replace('--password--', '$($AppProps.weblogic_password)').replace('--dom_dir--', '$($AppProps.dom_dir)') | Out-File $($AppProps.main_location)/temp/startupAdminserver.py -Encoding ASCII -Force"


iex "$($AppProps.wl_dir)/common/bin/wlst.cmd $($AppProps.main_location)/temp/startupAdminserver.py"

REM remote-chef-client-setup.bat hostname user pass [proxy:port]
set RHOST=%1
set RUSER=%2
set RPASS=%3
set RPROXY=%4
set RDIR=C:\
set RSETUP=chef-client-setup.vbs

REM mount the remote C: drive and copy %RSETUP% there
net use \\%RHOST%\C$ /user:%RUSER% %RPASS%
copy %RSETUP% \\%RHOST%\C$

REM http://technet.microsoft.com/en-us/sysinternals/bb897553.aspx
psexec \\%RHOST% -u %RUSER% -p %RPASS% -w %RDIR% cmd.exe /c cscript /nologo C:\%RSETUP% %RPROXY%

REM del %RSETUP% and unmount remote C: drive
del \\%RHOST%\C$\%RSETUP%
net use \\%RHOST%\C$ /del

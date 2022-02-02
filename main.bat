@echo off
echo Connect you to your ftp...
echo.
set /p host="Host: " 
set /p usrname="Username: "
powershell -Command $pword = read-host "Password " -AsSecureString ; $BSTR=[System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($pword) ; [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR) > .tmp.txt & set /p passwd=<.tmp.txt & del .tmp.txt
cls

ftp %host%
%usrname%
%passwd%

set /p command=" > "
:while
if command != "quit" (
    set /p command=""
) goto :while

pause

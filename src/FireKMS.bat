:: TITLE: FireKMS
:: AUTHOR: Joan Bono
:: VERSION: 1.0.0
:: USAGE: C:\Windows\System32> FireKMS.bat

@echo off

goto check_Permissions

:firekms
Echo ADDING FIREWALL RULE FOR KMS Pico Windows Activation

Echo Adding Inbound TCP rule...
netsh advfirewall firewall add rule name=KMSPicoINTCP dir=in action=allow localip=any localport=any remoteip=any remoteport=1688 protocol=TCP

Echo Adding Inbound UDP rule...
netsh advfirewall firewall add rule name=KMSPicoINUDP dir=in action=allow localip=any localport=any remoteip=any remoteport=1688 protocol=UDP

Echo Adding Outbound TCP rule...
netsh advfirewall firewall add rule name=KMSPicoOUTTCP dir=out action=allow localip=any localport=any remoteip=any remoteport=1688 protocol=TCP

Echo Adding Outbound UDP rule...
netsh advfirewall firewall add rule name=KMSPicoOUTUDP dir=out action=allow localip=any localport=any remoteip=any remoteport=1688 protocol=UDP

Echo Done! :D & echo.

goto EOF

:EOF
Echo Press ENTER to exit
pause > nul
exit


:check_Permissions
    echo Administrative permissions required. Detecting permissions... & echo.

    net session >nul 2>&1
    if %errorLevel% == 0 (
        Echo Success: Executing the program & echo.
        goto firekms
    ) else (
        Echo Failure: Execute as Administrator & echo.
        goto EOF
    )



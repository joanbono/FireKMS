<# 
.DESCRIPTION
    Firewall rules for KMS Pico Windows Activation
.REQUIRES
    Anything but love <3
.NOTES
    Name: FireKMS.ps1
    Author: Joan Bono <@joan_bono>
    Tested on Powershell v5.1
    Version: 1.0.0
.EXAMPLE
    .\FireKMS.ps1
#>

[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$ErrorActionPreference = "SilentlyContinue"

function WriteRules {
    Write-Host "`n`t [!]" -ForegroundColor Yellow -NoNewLine
    Write-Host "Adding Firewall Rules for KMS Pico Windows Activation...`n"

    Write-Host "`t [+]" -ForegroundColor Green -NoNewLine
    Write-Host "Adding Inbound TCP rule...`n"
    New-NetFirewallRule 
      -DisplayName "KMSPicoIN_TCP" 
      -Direction Inbound  
      -Action Allow
      -LocalAddress Any
      -LocalPort Any
      -RemoteAddress Any
      -RemotePort 1688
      -Protocol TCP
      -Enabled True

    Write-Host "`t [+]" -ForegroundColor Green -NoNewLine
    Write-Host "Adding Inbound UDP rule...`n"
    New-NetFirewallRule 
      -DisplayName "KMSPicoIN_UDP" 
      -Direction Inbound  
      -Action Allow
      -LocalAddress Any
      -LocalPort Any
      -RemoteAddress Any
      -RemotePort 1688
      -Protocol UDP
      -Enabled True
  
    Write-Host "`t [+]" -ForegroundColor Green -NoNewLine
    Write-Host "Adding Outbound TCP rule...`n"
    New-NetFirewallRule 
      -DisplayName "KMSPicoOUT_TCP" 
      -Direction Outbound  
      -Action Allow
      -LocalAddress Any
      -LocalPort Any
      -RemoteAddress Any
      -RemotePort 1688
      -Protocol TCP
      -Enabled True
  
    Write-Host "`t [+]" -ForegroundColor Green -NoNewLine
    Write-Host "Adding Outbound UDP rule...`n"
    New-NetFirewallRule 
      -DisplayName "KMSPicoOUT_UDP" 
      -Direction Inbound  
      -Action Allow
      -LocalAddress Any
      -LocalPort Any
      -RemoteAddress Any
      -RemotePort 1688
      -Protocol UDP
      -Enabled True

    Write-Host "`t [i]" -ForegroundColor Cyan -NoNewLine
    Write-Host "Done!`n"

}

function Test-IsAdmin  {
    $wid=[System.Security.Principal.WindowsIdentity]::GetCurrent()
    $prp=new-object System.Security.Principal.WindowsPrincipal($wid)
    $adm=[System.Security.Principal.WindowsBuiltInRole]::Administrator
    $IsAdmin=$prp.IsInRole($adm)
    if ($IsAdmin){
        WriteRules
    } else { 
        Write-Host "`n`t [-]" -ForegroundColor Red -NoNewLine
        Write-Host "Run the script as Administrator!`n" 
    }
}

Test-IsAdmin

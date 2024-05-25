#!/bin/bash
# Add WSL2 host search domains to resolv.conf

# Trigger from Windows scheduler:
# Log: Microsoft-Windows-NetworkProfile/Operational
# Source: NetworkProfile
# Event ID: 10000

PS=/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe
DNSSUF=$($PS -Command "Write-Host @(Get-DnsClient | Select-Object -Property ConnectionSpecificSuffix | Where-Object {\$_.ConnectionSpecificSuffix -ne \"\"} | %{\$_.ConnectionSpecificSuffix})")

# Remove all ^search lines from /etc/resolv.conf so this can be re-run; brutal but works
sed -i '/^search/d' /etc/resolv.conf
echo search $DNSSUF >> /etc/resolv.conf

# Sysmon Installation (Windows VM)

## 1. Download Sysmon
```powershell
Invoke-WebRequest -Uri https://download.sysinternals.com/files/Sysmon.zip -OutFile Sysmon.zip
Expand-Archive Sysmon.zip -DestinationPath C:\Tools\Sysmon
```

## 2. Install with this config
```powershell
cd C:\Tools\Sysmon
.\Sysmon64.exe -accepteula -i C:\soc-siem-lab\configs\sysmon\sysmonconfig.xml
```

## 3. Verify
```powershell
Get-Service Sysmon64
Get-WinEvent -LogName "Microsoft-Windows-Sysmon/Operational" -MaxEvents 5
```

## 4. Update config (without restart)
```powershell
.\Sysmon64.exe -c C:\soc-siem-lab\configs\sysmon\sysmonconfig.xml
```

## Events captured
| Event ID | Description |
|----------|-------------|
| 1 | Process creation |
| 3 | Network connection |
| 11 | File creation |
| 12/13 | Registry create/modify |
| 22 | DNS query |

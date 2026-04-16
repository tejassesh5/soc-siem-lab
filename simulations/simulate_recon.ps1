# Simulates post-exploitation reconnaissance commands on Windows
# Triggers Sysmon Event ID 1 (Process Creation) for common recon tools
# Run on Windows VM in the lab environment ONLY

Write-Host "[*] Starting recon simulation — watch Sysmon Event ID 1 in Kibana"
Write-Host "[*] Index: winlogbeat-* | Filter: winlog.event_id: 1"
Write-Host ""

$commands = @(
    @{ cmd = "whoami"; args = "/all" },
    @{ cmd = "ipconfig"; args = "/all" },
    @{ cmd = "net"; args = "user" },
    @{ cmd = "net"; args = "localgroup administrators" },
    @{ cmd = "net"; args = "view" },
    @{ cmd = "netstat"; args = "-ano" },
    @{ cmd = "tasklist"; args = "/v" },
    @{ cmd = "systeminfo"; args = "" },
    @{ cmd = "reg"; args = "query HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" }
)

foreach ($entry in $commands) {
    Write-Host "  [+] Running: $($entry.cmd) $($entry.args)"
    try {
        & $entry.cmd $entry.args 2>&1 | Out-Null
    } catch {}
    Start-Sleep -Milliseconds 500
}

Write-Host ""
Write-Host "[*] Done. Expected Sysmon events:"
Write-Host "    - Event 1: Process creation for whoami, ipconfig, net, netstat, tasklist"
Write-Host "    - Check Kibana dashboard: SOC Overview -> Process Creation panel"

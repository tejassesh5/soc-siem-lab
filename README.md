# soc-siem-lab

Reproducible SIEM home lab. Spin up Elastic Stack with one command, then ship Windows (Sysmon) and Linux (Zeek) telemetry into Kibana dashboards that mirror real SOC detection workflows.

## Architecture
```
Windows VM  →  Sysmon + Winlogbeat  ─┐
                                      ├→  Elasticsearch  →  Kibana
Linux VM    →  Zeek + Filebeat      ─┘
```

## Dashboards (planned)
- Authentication events (4625, 4740)
- Suspicious process execution / LOLBins
- PowerShell encoded commands
- Network anomalies (Zeek conn.log)
- Brute force detection

## Stack
- Elasticsearch 8.x + Kibana (Docker)
- Sysmon (SwiftOnSecurity config)
- Winlogbeat + Filebeat
- Zeek
- Atomic Red Team (attack simulation)

## Quick start
```bash
docker compose up -d
# then configure VM agents to point at host IP:9200
```

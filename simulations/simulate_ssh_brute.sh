#!/usr/bin/env bash
# Simulates SSH brute force attempts against localhost
# Generates auth.log entries picked up by Filebeat -> Elasticsearch
# Run on the Linux VM ONLY in the lab environment

TARGET=${1:-localhost}
USER_LIST=("root" "admin" "ubuntu" "pi" "test" "guest")
COUNT=${2:-20}

echo "[*] Simulating SSH brute force against $TARGET ($COUNT attempts)"

for i in $(seq 1 $COUNT); do
    user=${USER_LIST[$((RANDOM % ${#USER_LIST[@]}))]}
    port=$((RANDOM % 10000 + 50000))
    # Write directly to auth.log format (for lab without actual SSH server)
    echo "$(date '+%b %d %H:%M:%S') $(hostname) sshd[$$]: Failed password for $user from $TARGET port $port ssh2" \
        | sudo tee -a /var/log/auth.log > /dev/null
    echo "  [+] Failed password for $user from $TARGET port $port"
    sleep 0.2
done

echo "[*] Done. Check Kibana: linux-syslog-* index, filter: message:'Failed password'"

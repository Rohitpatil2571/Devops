#!/bin/bash

echo "==================== Server Performance Stats ===================="

# OS Version
echo -e "\n🖥️ OS Version:"
cat /etc/os-release | grep PRETTY_NAME | cut -d= -f2

# Uptime
echo -e "\n⏱️ Uptime:"
uptime -p

# Load Average
echo -e "\n📊 Load Average:"
uptime | awk -F'load average:' '{ print $2 }'

# Logged in Users
echo -e "\n👥 Logged in Users:"
who | wc -l

# Failed Login Attempts (last 24 hours)
echo -e "\n🔐 Failed Login Attempts (last 24h):"
journalctl _COMM=sshd --since "24 hours ago" | grep "Failed password" | wc -l

# CPU Usage
echo -e "\n🧠 Total CPU Usage:"
top -bn1 | grep "Cpu(s)" | awk '{print "Used: " $2 + $4 "%, Idle: " $8 "%"}'

# Memory Usage
echo -e "\n💾 Memory Usage:"
free -h | awk '/Mem:/ {printf "Used: %s / %s (%.2f%%)\n", $3, $2, $3/$2 * 100.0}'

# Disk Usage
echo -e "\n🗄️ Disk Usage:"
df -h --total | grep total | awk '{printf "Used: %s / %s (%s)\n", $3, $2, $5}'

# Top 5 Processes by CPU
echo -e "\n🔥 Top 5 Processes by CPU Usage:"
ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6

# Top 5 Processes by Memory
echo -e "\n💡 Top 5 Processes by Memory Usage:"
ps -eo pid,comm,%mem --sort=-%mem | head -n 6

echo -e "\n=================================================================="

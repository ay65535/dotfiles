#!/bin/bash
# https://self-development.info/%E3%80%90ubuntu%E3%80%91ntpdate%E3%81%A7%E3%81%AF%E3%81%AA%E3%81%8Ftimedatectl%E3%81%AB%E3%82%88%E3%82%8B%E6%99%82%E5%88%BB%E5%90%88%E3%82%8F%E3%81%9B/
# https://kenedori.hatenablog.com/entry/2022/12/10/050232

### Settings ###

NTP_SERVER=

### Main ###

timedatectl
# =>
#                Local time: Tue 2023-11-14 11:48:42 JST
#            Universal time: Tue 2023-11-14 02:48:42 UTC
#                  RTC time: Tue 2023-11-14 02:48:42
#                 Time zone: Asia/Tokyo (JST, +0900)
# System clock synchronized: yes
#               NTP service: inactive
#           RTC in local TZ: no

systemctl status --no-pager systemd-timesyncd.service
# =>
# ○ systemd-timesyncd.service - Network Time Synchronization
#      Loaded: loaded (/lib/systemd/system/systemd-timesyncd.service; enabled; vendor preset: enabled)
#      Active: inactive (dead)
#   Condition: start condition failed at Tue 2023-11-14 11:51:57 JST; 2min 22s ago
#              └─ ConditionVirtualization=!container was not met
#        Docs: man:systemd-timesyncd.service(8)
#
# Nov 07 09:08:40 xxxxxxx systemd[1]: Condition check resulted in Network Time Synchronization being skipped.
# Nov 14 11:51:57 xxxxxxx systemd[1]: Condition check resulted in Network Time Synchronization being skipped.

cat /etc/systemd/timesyncd.conf
test -e /etc/systemd/timesyncd.conf.orig || sudo cp -a /etc/systemd/timesyncd.conf{,.orig}

sudo sed -i'' "s/#NTP=/NTP=$NTP_SERVER/" /etc/systemd/timesyncd.conf

# for WSL2 {{

ls -la /etc/systemd/system/systemd-timesyncd.service.d

if [ -e /etc/systemd/system/systemd-timesyncd.service.d/override.conf ]; then
  mkdir -p ~/backups/etc/systemd/system/systemd-timesyncd.service.d
  cp -a /etc/systemd/system/systemd-timesyncd.service.d/override.conf ~/backups/etc/systemd/system/systemd-timesyncd.service.d/override."$(date +%y%m%d)".conf
else
  sudo mkdir -p /etc/systemd/system/systemd-timesyncd.service.d
fi

cat <<EOF | sudo tee /etc/systemd/system/systemd-timesyncd.service.d/override.conf
[Unit]
ConditionVirtualization=
EOF

# }}

sudo systemctl daemon-reload
sudo systemctl restart systemd-timesyncd

sudo timedatectl set-ntp true
timedatectl
# =>
#                Local time: Tue 2023-11-14 12:12:33 JST
#            Universal time: Tue 2023-11-14 03:12:33 UTC
#                  RTC time: Tue 2023-11-14 03:10:06
#                 Time zone: Asia/Tokyo (JST, +0900)
# System clock synchronized: yes
#               NTP service: active
#           RTC in local TZ: no

systemctl status systemd-timesyncd.service
# =>
# ● systemd-timesyncd.service - Network Time Synchronization
#      Loaded: loaded (/lib/systemd/system/systemd-timesyncd.service; enabled; vendor preset: enabled)
#     Drop-In: /etc/systemd/system/systemd-timesyncd.service.d
#              └─override.conf
#      Active: active (running) since Tue 2023-11-14 12:12:32 JST; 23s ago
#        Docs: man:systemd-timesyncd.service(8)
#    Main PID: 1389786 (systemd-timesyn)
#      Status: "Initial synchronization to time server."
#       Tasks: 2 (limit: 9390)
#      Memory: 1.3M
#      CGroup: /system.slice/systemd-timesyncd.service
#              └─1389786 /lib/systemd/systemd-timesyncd
#
# Nov 14 12:12:32 xxxxxxx systemd[1]: Starting Network Time Synchronization...
# Nov 14 12:12:32 xxxxxxx systemd[1]: Started Network Time Synchronization.
# Nov 14 12:12:32 xxxxxxx systemd-timesyncd[1389786]: Initial synchronization to time server.

#!/bin/bash
# https://www.server-world.info/query?os=Ubuntu_18.04&p=samba&f=2
# https://applingo.tokyo/article/9401

sudo apt update
sudo apt -y upgrade && sudo apt -y full-upgrade && sudo apt -y autoremove && sudo apt -y clean
sudo apt -y install samba

# smabaでのアクセス時のパスワードを設定します。
sudo pdbedit -a "$USER"

SMB_GROUP_NAME=sambashare

# Add your user to the samba group.
sudo usermod -aG $SMB_GROUP_NAME "$USER"
grep $SMB_GROUP_NAME /etc/group

#SMB_SHARED_DIR=/home/sambashare
SMB_SHARED_DIR=/home/shared

sudo mkdir $SMB_SHARED_DIR
sudo chgrp $SMB_GROUP_NAME $SMB_SHARED_DIR
sudo chmod 770 $SMB_SHARED_DIR
ls -la $SMB_SHARED_DIR

[ ! -f /etc/samba/smb.conf.orig ] && sudo cp -a /etc/samba/smb.conf /etc/samba/smb.conf.orig
sudo rm /tmp/smb.conf
cat /etc/samba/smb.conf >/tmp/smb.conf
ls -la /tmp/smb.conf

"$VSCODE_REMOTE_CLI" /tmp/smb.conf
# edit /tmp/smb.conf ..

ls -la /tmp/smb.conf /etc/samba/smb.conf
sudo chmod 644 /tmp/smb.conf
sudo chown root:root /tmp/smb.conf
sudo mv /tmp/smb.conf /etc/samba/smb.conf
ls -la /etc/samba/smb.conf*
cat /etc/samba/smb.conf

ls -lA /home/
ls -lA /home/shared/
ls -lA /home/sambashare/
touch /home/shared/a.txt
touch /home/sambashare/a.txt

systemctl status --no-pager smbd.service
sudo systemctl restart smbd
journalctl -xe --no-pager

# Stop
#sudo systemctl stop smbd

# Uninstall
#sudo apt -y purge samba && sudo apt -y autoremove && sudo apt -y clean
#sudo rm -rfv /var/lib/samba

### Samba : クライアントからの共有アクセス (Ubuntu) ###
# https://www.server-world.info/query?os=Ubuntu_22.04&p=samba&f=3

sudo apt -y install smbclient cifs-utils

# -- settings --
SMB_SERVER_IP=10.0.0.0
SMB_SHARED_DIR=~/shared
SMB_SHARED_DIRNAME=${SMB_SHARED_DIR##*/}
SMB_USER_NAME=user
SMB_USER_PASSWORD=password
# --------------

## [smbclient] コマンドでアクセスする ##

# smbclient (共有名) -U (ユーザー名)
# smbclient '\\$SMB_SERVER_IP\$SMB_SHARED_DIRNAME' -U $SMB_USER_NAME
# Enter WORKGROUP\$SMB_USER_NAME's password:
# Try "help" to get a list of possible commands.
# smb: \> ls
#   .                                   D        0  Mon May 16 01:30:45 2022
#   ..                                  D        0  Mon May 16 01:20:10 2022
#   testdir                             D        0  Mon May 16 01:30:45 2022
#   testfile.txt                        N       10  Mon May 16 01:30:37 2022
#
#                 27974664 blocks of size 1024. 20327404 blocks available
#
# ファイルをダウンロードする
# smb: \> mget "testfile.txt"
# Get file testfile.txt? y
# getting file \testfile.txt of size 10 as testfile.txt (4.9 KiloBytes/sec) (average 4.9 KiloBytes/sec)
# smb: \> !ls
# snap  testfile.txt
# smb: \> exit

## [mount] コマンドでアクセスする ##

mkdir $SMB_SHARED_DIR

# [vers=(SMB プロトコルのバージョン)]
# [username=(認証するユーザー名)]
sudo mount -t cifs -o vers=3.0,username=$SMB_USER_NAME "//$SMB_SERVER_IP/$SMB_SHARED_DIRNAME" $SMB_SHARED_DIR
sudo mount -t cifs -o vers=3.0,username=$SMB_USER_NAME,password=$SMB_USER_PASSWORD,file_mode=0644,dir_mode=0755,uid=1000,gid=1000 "//$SMB_SERVER_IP/$SMB_SHARED_DIRNAME" $SMB_SHARED_DIR
# Password for $SMB_USER_NAME@/$SMB_SERVER_IP/$SMB_SHARED_DIRNAME:  ********     # 認証ユーザーのパスワード

ls -laFh $SMB_SHARED_DIR

df -hT
# Filesystem                        Type   Size  Used Avail Use% Mounted on
# tmpfs                             tmpfs  393M  1.5M  392M   1% /run
# /dev/mapper/ubuntu--vg-ubuntu--lv ext4    27G  6.0G   20G  24% /
# tmpfs                             tmpfs  2.0G     0  2.0G   0% /dev/shm
# tmpfs                             tmpfs  5.0M     0  5.0M   0% /run/lock
# /dev/vda2                         ext4   2.0G  125M  1.7G   7% /boot
# tmpfs                             tmpfs  393M  4.0K  393M   1% /run/user/0
# //$SMB_SERVER_IP/$SMB_SHARED_DIRNAME           cifs    27G  7.3G   20G  28% /mnt

# 認証不要の共有へアクセスする場合は [none] 指定
mount -t cifs -o vers=3,username=none,password=none "//$SMB_SERVER_IP/Share" /mnt/Share

sudo umount $SMB_SHARED_DIR

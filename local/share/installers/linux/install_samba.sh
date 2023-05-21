#!/bin/bash
# https://www.server-world.info/query?os=Ubuntu_18.04&p=samba&f=1
# https://applingo.tokyo/article/9401

sudo apt update
sudo apt -y install samba
# smabaでのアクセス時のパスワードを設定します。
sudo pdbedit -a "$USER"

SMB_SHARED_DIR=/home/shared

SMB_GROUP_NAME=sambashare
SMB_SHARED_DIR=/home/sambashare

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

sudo systemctl status --no-pager smbd.service
sudo systemctl restart smbd
journalctl -xe --no-pager

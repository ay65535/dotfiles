#!/bin/bash

# sudo systemctl daemon-reload
sudo apt update
apt list --upgradable 
sudo apt -y upgrade
sudo apt -y full-upgrade
sudo apt -y autoremove
sudo apt -y clean

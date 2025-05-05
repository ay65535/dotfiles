#!/bin/bash

cat <<EOF | sudo tee /etc/sudoers.d/010_$USER-nopasswd
$USER ALL=(ALL) NOPASSWD: ALL
EOF

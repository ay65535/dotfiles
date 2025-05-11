#!/bin/bash
# https://docs.rancherdesktop.io/how-to-guides/rancher-on-rancher-desktop/

nerdctl run --privileged -d --restart=always -p 8080:80 -p 8443:443 rancher/rancher

nerdctl logs "$(nerdctl ps -q)" 2>&1 | grep "Bootstrap Password:"

# Go to https://localhost:8443/

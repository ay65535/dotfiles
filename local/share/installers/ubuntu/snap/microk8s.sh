#!/bin/bash
# https://microk8s.io/docs/install-wsl2

# containerdのプロキシ設定 #
# https://microk8s.io/docs/install-proxy

# backup
sudo mv /etc/environment /etc/environment.orig
sudo cp -a /etc/environment.orig /etc/environment
# shellcheck disable=SC2154
cat <<EOF | sudo tee -a /etc/environment

# for microk8s
http_proxy=$http_proxy
HTTP_PROXY=$http_proxy
https_proxy=$https_proxy
HTTPS_PROXY=$https_proxy
no_proxy=$no_proxy
NO_PROXY=$no_proxy
EOF

# check
cat /etc/environment

# Install #
sudo snap list
sudo snap install microk8s --classic

# https://zenn.dev/rrrrrrryo/scraps/d2bbb346094131
# sudo mv /var/snap/microk8s/current/args/containerd-env /var/snap/microk8s/current/args/containerd-env.orig
# sudo cp -a /var/snap/microk8s/current/args/containerd-env.orig /var/snap/microk8s/current/args/containerd-env
# # shellcheck disable=SC2154
# sudo sed -i"" -e "s|# HTTPS_PROXY=https://squid.internal:3128|HTTPS_PROXY=$https_proxy|" /var/snap/microk8s/current/args/containerd-env
# # shellcheck disable=SC2154
# sudo sed -i"" -e "s|# NO_PROXY=10.1.0.0/16,10.152.183.0/24|NO_PROXY=$no_proxy|" /var/snap/microk8s/current/args/containerd-env
# # reset
# sudo mv /var/snap/microk8s/current/args/containerd-env.orig /var/snap/microk8s/current/args/containerd-env
# sudo cat /var/snap/microk8s/current/args/containerd-env
# sudo microk8s stop; sudo microk8s start

sudo microk8s status
sudo microk8s status --wait-ready
# =>
# microk8s is running
# high-availability: no
#   datastore master nodes: 127.0.0.1:19001
#   datastore standby nodes: none
# addons:
#   enabled:
#     dns                  # (core) CoreDNS
#     ha-cluster           # (core) Configure high availability on the current node
#     helm                 # (core) Helm - the package manager for Kubernetes
#     helm3                # (core) Helm 3 - the package manager for Kubernetes
#   disabled:
#     cert-manager         # (core) Cloud native certificate management
#     cis-hardening        # (core) Apply CIS K8s hardening
#     community            # (core) The community addons repository
#     dashboard            # (core) The Kubernetes dashboard
#     gpu                  # (core) Alias to nvidia add-on
#     host-access          # (core) Allow Pods connecting to Host services smoothly
#     hostpath-storage     # (core) Storage class; allocates storage from host directory
#     ingress              # (core) Ingress controller for external access
#     kube-ovn             # (core) An advanced network fabric for Kubernetes
#     mayastor             # (core) OpenEBS MayaStor
#     metallb              # (core) Loadbalancer for your Kubernetes cluster
#     metrics-server       # (core) K8s Metrics Server for API access to service metrics
#     minio                # (core) MinIO object storage
#     nvidia               # (core) NVIDIA hardware (GPU and network) support
#     observability        # (core) A lightweight observability stack for logs, traces and metrics
#     prometheus           # (core) Prometheus operator for monitoring and logging
#     rbac                 # (core) Role-Based Access Control for authorisation
#     registry             # (core) Private image registry exposed on localhost:32000
#     rook-ceph            # (core) Distributed Ceph storage using Rook
#     storage              # (core) Alias to hostpath-storage add-on, deprecated

sudo microk8s kubectl get node -o wide

# Enable services and start using Kubernetes!
sudo microk8s enable dns
sudo microk8s enable hostpath-storage
sudo microk8s enable dashboard
# If RBAC is not enabled access the dashboard using the token retrieved with:
sudo microk8s kubectl describe secret -n kube-system microk8s-dashboard-token
# Use this token in the https login UI of the kubernetes-dashboard service.

# In an RBAC enabled setup (microk8s enable RBAC) you need to create a user with restricted
# permissions as shown in:
# https://github.com/kubernetes/dashboard/blob/master/docs/user/access-control/creating-sample-user.md

sudo microk8s kubectl get pod -n kube-system hostpath-provisioner-756cd956bc-lxbf2

# To access the dashboard, MicroK8s offers a helper command:
sudo microk8s dashboard-proxy

# MicroK8s wraps the kubectl binary, and you can use it to interact with the cluster:
# sudo microk8s kubectl create deploy --image nginx --replicas 3 nginx

# Uninstall
# sudo microk8s stop
# sudo snap remove --purge microk8s

#!/bin/bash
# https://kind.sigs.k8s.io/docs/user/using-wsl2/#kubernetes-service-with-session-affinity

# Build a kernel with xt_recent kernel module enabled

cat <<EOS
http_proxy  : $http_proxy
https_proxy : $https_proxy
ftp_proxy   : $ftp_proxy
no_proxy    : $no_proxy
EOS

docker run --name wsl-kernel-builder --rm -it \
  -e http_proxy="$http_proxy" \
  -e https_proxy="$https_proxy" \
  -e ftp_proxy="$ftp_proxy" \
  -e no_proxy="$no_proxy" \
  -v "${PWD}:/mnt/host" \
  ubuntu:latest bash

WSL_COMMIT_REF=linux-msft-wsl-$(uname -r | awk -F- '{ print $1 }')
WSL_COMMIT_REF=linux-msft-wsl-5.15.90.1 # change this line to the version you want to build
echo $WSL_COMMIT_REF
WSL_COMMIT_BRANCH=${WSL_COMMIT_REF%.*}
WSL_COMMIT_BRANCH=${WSL_COMMIT_BRANCH%.*}.y
echo "$WSL_COMMIT_BRANCH"

# Install dependencies
apt update
apt -y upgrade --no-install-recommends
apt -y full-upgrade --no-install-recommends
apt -y install --no-install-recommends git build-essential flex bison libssl-dev libelf-dev bc \
  python3 pahole libncurses-dev

# Checkout WSL2 Kernel repo
mkdir src
cd src || exit
git init
git remote add origin https://github.com/microsoft/WSL2-Linux-Kernel.git
git config --local gc.auto 0
git -c protocol.version=2 fetch --no-tags --prune --progress --no-recurse-submodules --depth=1 origin +${WSL_COMMIT_REF}:refs/remotes/origin/build/"$WSL_COMMIT_BRANCH"
git checkout --progress --force -B build/"$WSL_COMMIT_BRANCH" refs/remotes/origin/build/"$WSL_COMMIT_BRANCH"

git reset --hard
git clean -xdf .

# Enable xt_recent kernel module
sed -i 's/# CONFIG_NETFILTER_XT_MATCH_RECENT is not set/CONFIG_NETFILTER_XT_MATCH_RECENT=y/' Microsoft/config-wsl
git diff

# Compile the kernel
#make -j2 KCONFIG_CONFIG=Microsoft/config-wsl
export KCONFIG_CONFIG=Microsoft/config-wsl
# https://zenn.dev/ignorant/articles/wsl2_alpine_docker
make menuconfig
make -j"$(nproc)"

cp /src/arch/x86/boot/bzImage /mnt/host/bzImage

# From the host terminal copy the newly built kernel
#docker cp wsl-kernel-builder:/src/arch/x86/boot/bzImage .
exit

# Configure WSL to use newly built kernel: https://docs.microsoft.com/en-us/windows/wsl/wsl-config#configure-global-options-with-wslconfig

# Create a .wslconfig file in C:\Users\<your-user-name>\:
WIN_USER=$(ls -1tr /mnt/c/Users/ | tail -1)
ls -lA /mnt/c/Users/$WIN_USER
cat /mnt/c/Users/$WIN_USER/.wslconfig
cp ./bzImage /mnt/c/Users/$WIN_USER/bzImage

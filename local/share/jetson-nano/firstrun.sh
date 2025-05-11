#!/bin/bash

cat /etc/nv_tegra_release
# ==> # R32 (release), REVISION: 7.6, GCID: 38171779, BOARD: t210ref, EABI: aarch64, DATE: Tue Nov  5 07:46:14 UTC 2024

cat /proc/version
# ==> Linux version 4.9.337-tegra (buildbrain@mobile-u64-5499-d7000) (gcc version 7.3.1 20180425 [linaro-7.3-2018.05 revision d29120a424ecfbc167ef90065c0eeb7f91977701] (Linaro GCC 7.3-2018.05) ) #1 SMP PREEMPT Mon Nov 4 23:41:41 PST 2024

uname -a
# ==> Linux jetson-nano 4.9.337-tegra #1 SMP PREEMPT Mon Nov 4 23:41:41 PST 2024 aarch64 aarch64 aarch64 GNU/Linux

# (existing)
ls -l /etc/ld.so.conf.d/nvidia-tegra*
cat /etc/ld.so.conf.d/nvidia-tegra.conf.dpkg-old
cat /etc/ld.so.conf.d/nvidia-tegra.conf
# --- /etc/ld.so.conf.d/nvidia-tegra.conf 2025-05-08 00:19:18.893852342 +0900
# +++ /etc/ld.so.conf.d/nvidia-tegra.conf.dpkg-new        2024-11-05 16:45:15.000000000 +0900
# @@ -1 +1,11 @@
# -/usr/lib/aarch64-linux-gnu/tegra
# +/usr/lib/tegra
ls -l /usr/lib/aarch64-linux-gnu/tegra
# ==> OK
ls -l /usr/lib/tegra
# ==> ls: cannot access '/usr/lib/tegra': No such file or directory
sudo mv /etc/ld.so.conf.d/nvidia-tegra.conf{,.dpkg-new}
sudo mv /etc/ld.so.conf.d/nvidia-tegra.conf{.dpkg-old,}
ls -l /etc/ld.so.conf.d/nvidia-tegra*
diff -u /etc/ld.so.conf.d/nvidia-tegra.conf{,.dpkg-new}

# (new file)
# ls -l /etc/systemd/nv-oem-config-post*
# cat /etc/systemd/nv-oem-config-post.sh

# (new file)
# ls -l /etc/systemd/nv-oem-config*
# cat /etc/systemd/nv-oem-config.sh

# https://code.visualstudio.com/docs/setup/linux#_visual-studio-code-is-unable-to-watch-for-file-changes-in-this-large-workspace-error-enospc
cat /proc/sys/fs/inotify/max_user_watches
# ==> 8192

[ ! -f /etc/sysctl.conf.orig ] && sudo cp -a /etc/sysctl.conf /etc/sysctl.conf.orig
sudo vim /etc/sysctl.conf
# fs.inotify.max_user_watches=524288

# The new value can then be loaded in by running
sudo sysctl -p

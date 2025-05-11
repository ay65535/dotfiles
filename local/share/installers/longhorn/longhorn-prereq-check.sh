#!/bin/bash
# Longhorn互換性確認スクリプト for Raspberry Pi / Jetson Nano

# Longhorn: https://longhorn.io/

echo "========== システム情報 =========="
echo "ホスト名: $(hostname)"
echo "カーネルバージョン: $(uname -r)"
echo "OS情報: $(grep PRETTY_NAME /etc/os-release | cut -d'"' -f2)"
echo "アーキテクチャ: $(uname -m)"
echo ""

echo "========== ハードウェアリソース =========="
echo "CPU コア数: $(nproc)"
echo "メモリ総量: $(free -h | grep Mem | awk '{print $2}')"
echo "利用可能メモリ: $(free -h | grep Mem | awk '{print $7}')"
echo "ディスク情報:"
df -h / | grep -v Filesystem

echo ""
echo "========== 必須カーネルモジュール確認 =========="

# NFSv4
if lsmod | grep -q "nfs"; then
  echo "✅ NFS モジュール: 読み込み済み"
else
  echo "❌ NFS モジュール: 未読み込み"
fi

# iSCSI関連モジュール
iscsi_modules=("iscsi_tcp" "scsi_transport_iscsi" "libiscsi" "libiscsi_tcp")
for module in "${iscsi_modules[@]}"; do
  if lsmod | grep -q "$module"; then
    echo "✅ $module: 読み込み済み"
  else
    echo "❌ $module: 未読み込み"
  fi
done

# マウントプロパゲーション確認
if mount | grep -q "shared"; then
  echo "✅ マウントプロパゲーション: 有効"
else
  echo "⚠️ マウントプロパゲーション: 確認必要"
fi

echo ""
echo "========== open-iscsi確認 =========="
if command -v iscsiadm &>/dev/null; then
  echo "✅ open-iscsi: インストール済み ($(iscsiadm --version))"
else
  echo "❌ open-iscsi: 未インストール"
fi

echo ""
echo "========== 必要なユーティリティ確認 =========="
utils=("curl" "findmnt" "grep" "awk" "blkid" "lsblk")
for util in "${utils[@]}"; do
  if command -v $util &>/dev/null; then
    echo "✅ $util: インストール済み"
  else
    echo "❌ $util: 未インストール"
  fi
done

echo ""
echo "========== Kubernetes/k3s確認 =========="
if command -v kubectl &>/dev/null; then
  echo "✅ kubectl: インストール済み ($(kubectl version --client))"
else
  echo "❌ kubectl: 未インストール"
fi

if systemctl is-active --quiet k3s || systemctl is-active --quiet k3s-agent; then
  echo "✅ k3s: 実行中"
else
  echo "❌ k3s: 未実行"
fi

echo ""
echo "========== 必要なパッケージインストール手順 =========="
echo "不足しているモジュールをインストールするコマンド:"
echo "sudo apt-get update && sudo apt-get install -y open-iscsi nfs-common"
echo ""
echo "不足しているカーネルモジュールを読み込むコマンド:"
echo "sudo modprobe nfs"
echo "sudo modprobe iscsi_tcp"
echo "sudo modprobe scsi_transport_iscsi"
echo "sudo systemctl enable --now iscsid"

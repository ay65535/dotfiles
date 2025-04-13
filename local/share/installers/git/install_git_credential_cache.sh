#!/bin/bash
# filepath: /home/pi/.dotfiles/local/share/installers/git/install_git_credential_cache.sh
#
# git-credential-cache を使用したGit認証情報管理のセットアップスクリプト
# Raspberry Pi OS 64bit Lite (bookworm) 向け

set -e

echo "git-credential-cache によるGitの認証情報管理をセットアップします..."
echo "このモードはパスワードをメモリに一時的に保存します。"

# キャッシュ保持時間の設定（デフォルト：900秒 = 15分）
timeout=900

# 引数で保持時間を指定できるようにする
if [ "$1" -gt 0 ] 2>/dev/null; then
  timeout=$1
  echo "指定された保持時間を使用します: ${timeout}秒"
else
  echo "デフォルトの保持時間を使用します: ${timeout}秒"
fi

# Git認証情報ヘルパーの設定
git config --global credential.helper "cache --timeout=${timeout}"

echo ""
echo "git-credential-cacheの設定が完了しました。"
echo "認証情報は ${timeout} 秒間メモリに保持されます。"
echo "その後は再度パスワードの入力が必要になります。"

# 現在の設定を表示
echo ""
echo "現在のGit認証情報ヘルパー設定:"
git config --global --get credential.helper

exit 0

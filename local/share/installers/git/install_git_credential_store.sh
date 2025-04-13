#!/bin/bash
# filepath: /home/pi/.dotfiles/local/share/installers/git/install_git_credential_store.sh
#
# git-credential-store を使用したGit認証情報管理のセットアップスクリプト
# Raspberry Pi OS 64bit Lite (bookworm) 向け

set -e

echo "git-credential-store によるGitの認証情報管理をセットアップします..."
echo "注意: このモードは認証情報をファイルに平文で保存します。"

# 保存先ファイルの指定
credential_path=~/.secret/git/credentials

# 絶対パスに変換
credential_path=$(realpath -m "$credential_path")

# Git認証情報ヘルパーの設定
git config --global credential.helper "store --file ${credential_path}"

echo ""
echo "git-credential-storeの設定が完了しました。"
echo "認証情報は ${credential_path} に保存されます。"
echo "新しいリポジトリでの最初のプッシュ時にユーザー名とパスワードを入力すると、"
echo "その情報が保存され、次回からは自動的に使用されます。"

# 現在の設定を表示
echo ""
echo "現在のGit認証情報ヘルパー設定:"
git config --global --get credential.helper

exit 0

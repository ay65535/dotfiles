#!/bin/bash
# filepath: /home/pi/.dotfiles/local/share/installers/git/install_git_credential_pass.sh
#
# GPG+passを使用したGit認証情報管理のセットアップスクリプト
# Raspberry Pi OS 64bit Lite (bookworm) 向け

set -e

echo "GPG+パスワードストアによるGitの認証情報管理をセットアップします..."

# 必要なパッケージのインストール
echo "必要なパッケージをインストールしています..."
sudo apt update
sudo apt install -y pass gnupg2

# GPGキーの存在確認
if ! gpg --list-secret-keys | grep -q "sec "; then
  echo ""
  echo "GPGキーが見つかりません。新しいGPGキーを生成します。"
  echo "以下の情報で自動的にGPGキーを生成します："

  # 必要な情報の設定
  NAME="${FULLNAME:-$(whoami)}"
  EMAIL="${EMAIL:-$(whoami)@$(hostname -f)}"
  COMMENT="Git Credential Store"

  # 設定ファイルを作成
  cat >/tmp/gpg-genkey-input <<EOF
%echo Generating a GPG key
Key-Type: RSA
Key-Length: 4096
Subkey-Type: RSA
Subkey-Length: 4096
Name-Real: ${NAME}
Name-Comment: ${COMMENT}
Name-Email: ${EMAIL}
Expire-Date: 0
%no-protection
%commit
%echo Done
EOF

  # キー生成
  gpg --batch --generate-key /tmp/gpg-genkey-input
  rm -f /tmp/gpg-genkey-input

  echo "GPGキーを生成しました。"
else
  echo "既存のGPGキーが見つかりました。"
fi

# GPGキーIDの取得（最初のキーを自動選択）
GPG_ID=$(gpg --list-secret-keys --keyid-format LONG | grep sec | head -n 1 | sed 's/.*\/\([^ ]*\) .*/\1/')

if [ -z "$GPG_ID" ]; then
  echo "エラー: GPGキーIDを取得できませんでした。"
  exit 1
fi

echo "GPGキーID: $GPG_ID を使用します。"

# passデータベースの初期化
if ! pass ls &>/dev/null; then
  echo "passデータベースを初期化します..."
  pass init "$GPG_ID"
else
  echo "passデータベースはすでに初期化されています。"
fi

# Git認証情報ヘルパーとしてpassを設定
echo "Gitの認証情報ヘルパーとしてpass-git-helperを設定します..."

# pass-git-helperがインストールされているか確認
if ! command -v pass-git-helper &>/dev/null; then
  echo "pass-git-helperをインストールしています..."
  sudo apt install -y pass-git-helper
fi

# グローバル設定
git config --global credential.helper 'pass-git-helper'

# 必要に応じて~/.config/pass-git-helperディレクトリを作成
mkdir -p ~/.config/pass-git-helper

# 設定ファイルが存在しない場合は作成
if [ ! -f ~/.config/pass-git-helper/git-pass-mapping.ini ]; then
  cat >~/.config/pass-git-helper/git-pass-mapping.ini <<EOF
# 認証情報のマッピング
# 以下はGitHubの例です。必要に応じて他のサービスも追加してください

[github.com]
target=dev/github
username_extractor=regex_search
username_pattern=github.com/([^/]+)

[gitlab.com]
target=dev/gitlab
username_extractor=regex_search
username_pattern=gitlab.com/([^/]+)

# 他のGitサービスも同様に追加できます
EOF
  echo "pass-git-helperの設定ファイルを作成しました: ~/.config/pass-git-helper/git-pass-mapping.ini"
  echo "必要に応じてこのファイルを編集し、使用するGitサービスを追加してください。"
else
  echo "pass-git-helperの設定ファイルは既に存在します。"
fi

echo ""
echo "認証情報を追加するには、以下のコマンドを実行してください:"
echo "  例: pass insert dev/github/username@github.com"
echo ""
echo "これでpass+GPGを使ったGit認証情報管理の設定が完了しました。"
echo "新しいリポジトリをクローンするか、既存のリポジトリでpushする際に、"
echo "最初の一度だけパスワードを入力すれば、その後は自動的に保存された認証情報が使用されます。"

# 現在の設定を表示
echo ""
echo "現在のGit認証情報ヘルパー設定:"
git config --global --get credential.helper

exit 0

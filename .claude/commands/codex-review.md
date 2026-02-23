---
description: codex CLIにコードレビューを依頼する
argument-hint: [--base <branch> | --commit <sha> | --uncommitted | <カスタム指示テキスト>]
allowed-tools: Bash
---

<!--
使い方:
  /codex-review                          → 未コミット変更をレビュー（デフォルト）
  /codex-review --base main              → mainブランチとの差分をレビュー
  /codex-review --commit abc123          → 特定コミットをレビュー
  /codex-review --uncommitted セキュリティの観点で重点レビュー  → カスタム指示付き
  /codex-review バグが多そうな箇所を重点的に見てください       → 指示のみでもOK

codex review の仕様:
  codex review [OPTIONS] [PROMPT]
    --uncommitted  ステージ済み/未ステージ/未追跡変更をレビュー
    --base <branch>  指定ブランチとの差分をレビュー
    --commit <sha>  特定コミットの変更をレビュー
    [PROMPT]        カスタムレビュー指示（オプション）
-->

Bashツールを使ってcodex CLIのレビューコマンドを実行してください。

まず現在のgit状況を確認してください：

現在のブランチ: !`git branch --show-current`
変更状況: !`git status --short`

次に、以下のルールに従ってcodex reviewを実行してください：

**引数 `$ARGUMENTS` の処理ルール：**
- `$ARGUMENTS` が空 → `codex review --uncommitted` を実行
- `$ARGUMENTS` が `--base`・`--commit`・`--uncommitted` を含む → `codex review $ARGUMENTS` をそのまま実行
- `$ARGUMENTS` がその他のテキスト（カスタム指示）→ `codex review --uncommitted "$ARGUMENTS"` を実行

コマンド実行後、レビュー結果を日本語で以下の形式にまとめてください：

## Codexレビュー結果

### 重要な問題点
（Critical / High レベルの問題があれば列挙）

### 改善提案
（Medium / Low レベルの提案を列挙）

### 良い点
（良い実装・パターンがあれば列挙）

### 総評
（全体的な評価を1〜3文で）

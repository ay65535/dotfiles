# syntax=docker/dockerfile:1
FROM ubuntu:24.04

# 対話的プロンプトをスキップ
ENV DEBIAN_FRONTEND=noninteractive

# (オプション) マニュアル(man)など、削ぎ落とされたUbuntu Server標準パッケージを復元
# RUN yes | unminimize

# WSLと同等の必須ツールをインストール
RUN apt-get update && apt-get install -y --no-install-recommends \
    sudo \
    git \
    curl \
    wget \
    openssh-client \
    vim \
    nano \
    less \
    rsync \
    lsof \
    netcat-openbsd \
    byobu \
    tmux \
    ca-certificates \
    tzdata \
    locales \
    && rm -rf /var/lib/apt/lists/*

# 日本語環境の設定 (optional)
# RUN locale-gen ja_JP.UTF-8
# ENV LANG=ja_JP.UTF-8
ENV TZ=Asia/Tokyo

# パスワードはここで入れない
# USER も切り替えず root のままにしておく
RUN usermod -aG sudo ubuntu

COPY .devcontainer/scripts/init-password.sh /usr/local/bin/init-password.sh
RUN chmod 0755 /usr/local/bin/init-password.sh

ENTRYPOINT ["/usr/local/bin/init-password.sh"]
CMD ["sleep", "infinity"]

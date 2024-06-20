FROM python:3.12-slim

ARG USERNAME=user

RUN apt-get update -y \
    && DEBIAN_FRONTEND=noninteractive \
    apt-get install -y --no-install-recommends \
    locales \
    tzdata \
    git \
    ca-certificates \
    openssh-client \
    python3-tk \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && locale-gen ja_JP.UTF-8 \
    && localedef -f UTF-8 -i ja_JP ja_JP.UTF-8

# 環境変数の設定
ENV TZ=Asia/Tokyo \
    LANG=ja_JP.UTF-8 \
    LANGUAGE=ja_JP:jp \
    LC_ALL=ja_JP.UTF-8

# pipとsetuptoolsのアップグレード
RUN pip install --upgrade pip setuptools

# ユーザーの作成とディレクトリの所有権の設定
RUN groupadd -r $USERNAME && useradd -r -g $USERNAME $USERNAME \
    && mkdir -p /home/$USERNAME/workspaces \
    && chown -R $USERNAME:$USERNAME /home/$USERNAME

# 作業ディレクトリの設定
WORKDIR /home/$USERNAME/workspaces

# 必要なPythonパッケージのインストール
COPY --chown=$USERNAME:$USERNAME ./requirements.txt requirements.txt
RUN pip install -r requirements.txt

# ユーザーの切り替え
USER $USERNAME

# エントリーポイントの設定
ENTRYPOINT [ "/bin/bash" ]

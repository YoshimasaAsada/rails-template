FROM ruby:3.1.2

# パッケージのインストール
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# 作業ディレクトリの設定
WORKDIR /app

# ホストのGemfileとGemfile.lockをコンテナにコピー
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock

# Bundler経由でgemsをインストール
RUN bundle install

# ホストの残りのファイルをコンテナにコピー
COPY . /app

# puma.sockを配置するディレクトリを作成
RUN mkdir -p tmp/sockets

# デフォルトコマンドの設定
CMD ["rails", "server", "-b", "0.0.0.0"]

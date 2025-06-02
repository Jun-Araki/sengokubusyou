# ベースイメージとしてRubyを使用
# 指定されたRubyバージョン '3.1.2' と Rails 6.1.x に対応するディストリビューションを選択
FROM ruby:3.1.2-buster

# apt-get updateなどで必要なパッケージをインストール
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs default-jdk yarn

# アプリケーションの作業ディレクトリを設定
WORKDIR /app

# GemfileとGemfile.lockをコピーして依存関係をインストール
# これにより、アプリケーションコードの変更があってもバンドルが再実行されにくくなる
COPY Gemfile Gemfile.lock ./
RUN bundle install

# アプリケーションのコードをコンテナにコピー
COPY . .

# 開発環境でRailsサーバーを起動するためのポートを公開
EXPOSE 3000

# コンテナ起動時に実行されるコマンド
# Railsサーバーを起動する際は `rails s -b 0.0.0.0` のようにバインドアドレスを指定する必要がある
CMD ["bundle", "exec", "rails", "s", "-b", "0.0.0.0"]

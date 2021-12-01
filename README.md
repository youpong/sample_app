# Ruby on Rails チュートリアルのサンプルアプリケーション

これは、次の教材で作られたサンプルアプリケーションです。
[*Ruby on Rails チュートリアル*](https://railstutorial.jp/)（第6版）
[Michael Hartl](https://www.michaelhartl.com/) 著

## ライセンス

[Ruby on Rails チュートリアル](https://railstutorial.jp/)内にある
ソースコードはMITライセンスとBeerwareライセンスのもとで公開されています。
詳細は [LICENSE.md](LICENSE.md) をご覧ください。

## 使い方

このアプリケーションを動かす場合は、まずはリポジトリを手元にクローンしてください。
その後、Bundler を使って必要なライブラリ(RubyGems) をインストールします。

(*)ライブラリをインストールするには、その場所にあなたの書き換え権限が必要です。ライブラリの
インストール先は指定できます。下記のようにすればアプリケーションのトップディレクトリ以下
の(vendor/bundle)にライブラリをインストールします。

```
$ bin/bundle config set --local path 'vendor/bundle'
```

RubyGems のインストール

```
$ bin/bundle config set --local without 'production'
$ bin/bundle install
```

その後、データベースへのマイグレーションを実行します。

```
$ bin/rails db:migrate
```

最後に、テストを実行してうまく動いているかどうか確認してください。

```
$ bin/rails test
```

テストが無事に通ったら、Railsサーバーを立ち上げる準備が整っているはずです。

```
$ bin/rails server
```

詳しくは、[*Ruby on Rails チュートリアル*](https://railstutorial.jp/)
を参考にしてください。

## 参考

https://github.com/yasslab/sample_apps

# How to Update Webpacker

changing your `Gemfile`:

```ruby
gem 'webpacker', '~> 6.0'
```

Then running the following to install Webpacker:

```bash
$ bin/bundle install
$ bin/rails webpacker:install
```

When `package.json` and/or `yarn.lock` changes, such as when pulling down changes to your
local environment in a team settings, be sure to keep your NPM packages up-to-date:

```bash
$ yarn install
```


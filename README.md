# みんなの戦国武将

- アプリ → https://sengokubusyou.herokuapp.com/
- Qiita → https://qiita.com/TS1engineer
- Twitter → https://twitter.com/TS1engineer
- Wantedly → https://www.wantedly.com/id/jun_araki_a

# 1. 概要

- **200 人以上の豊富な戦国武将の中から、好きな武将を見つけたり、登録することができます。**
- **好きな武将にコメントを投稿することで、気の合う仲間とつながることができるアプリです。**

![top_image](https://user-images.githubusercontent.com/105146615/204910630-1ec301e0-2701-43ca-bc03-8863a79f6f4d.png)

# 2. 開発背景

## 歴史が大好き

2016 年大河ドラマ「真田丸」をきっかけに歴史に興味をもち、歴史の本を購入したりする中で、実際に現地に行くことが趣味になりました。  
中でも戦国武将について調べることが日課となっていて、特に気になる武将がいれば、ゆかりの地を巡ったりしています。

## 歴史を通じて交流がしたい

そうした中で、現地に行って得られた体験を共有したかったのですが、同世代に好きな人がおらず、ひとりで楽しむ程度でした。  
そのため、「歴史に興味のある人との交流できたらいいな」と思っていたため、今回アプリを作ることを決めました。

## 歴史好きをもっと増やしたい

歴史の授業で習うものは形式的すぎるので、もう少し気軽に歴史に興味を持ってもらいたいと思っています。  
「あの戦国武将と自分の出身地が一緒」というだけでも興味を持ちやすいですし、そういう方にぜひ使ってもらいたいアプリです。

# 3. 開発環境

## 使用技術

| 項目             | 内容                 |
| ---------------- | -------------------- |
| 言語             | Ruby 3.1.2           |
| フレームワーク   | Ruby on Rails 6.1.7  |
| フロントエンド   | HTML/scss/JavaScript |
| データベース     | PostgreSQL           |
| コード解析       | RuboCop              |
| ソースコード管理 | GitHub               |
| インフラ         | Heroku/AWS(S3)       |

## ER 図
![erzu](https://user-images.githubusercontent.com/105146615/204910877-4aff8843-c80e-4d43-8cc6-1f05d6b5c85a.png)

## 画面遷移図

![gamensenizu](https://user-images.githubusercontent.com/105146615/205252286-3a8418e0-d705-4b3c-965c-90818c3ee370.png)

# 4. 機能

## 機能一覧

| 項目         | 内容                                                             |
| ------------ | ---------------------------------------------------------------- |
| ログイン関連 | ログイン、ゲストログイン、ログアウト、パスワード再設定メール送信 |
| ユーザー関連 | 登録、編集、削除                                                 |
| 武将検索     | 名前検索、50 音検索、出身地検索                                  |
| 武将登録     | 登録、編集、削除                                                 |
| いいね       | 武将にいいねできる                                               |
| コメント     | 武将にコメントできる                                             |
| ランキング   | いいね数/コメント数ランキング                                    |
| フォロー     | ユーザーのフォロー、アンフォロー                                 |
| マイページ   | 登録/いいね/コメントした武将一覧、フォロー/フォロワー一覧        |

## 使い方

### 武将検索（50 音）

![index](https://user-images.githubusercontent.com/105146615/204918007-0e2f2fc2-5331-40ba-886a-d6a2aea3f146.gif)


### 武将検索（出身地）

![prefecture](https://user-images.githubusercontent.com/105146615/204918036-d40a3699-050d-4341-9916-2c82eb583395.gif)


### マイページ

![mypage](https://user-images.githubusercontent.com/105146615/204918063-db0e3c09-2096-424a-8db8-6df72d4487b9.gif)


# 5. 工夫した点

- **実務開発を想定**  
  実務開発を想定し、現職でも利用している PDCA サイクルを意識して取り組みました。  
  `PLAN`：大・中・小目標に分類して、独自のガントチャートを作成し、進捗を管理しながら進めました。  
  `DO`：とにかく手を動かすことを意識し、20 分考えても分からない場合はメンターへ質問しながら進めました。  
  `CHECK`：入会しているスクールの週次ミーティングで進捗状況やアプリのレビューを行い、内容を修正しながら進めました。  
  `ACTION`：レビューで指摘された点はもちろん、同様の点が他にもないか考えながら、修正していきました。

- **チーム開発を想定**  
  チーム開発を想定し、以下のサイクルで行いました。
  1. 開発ブランチを切る
  1. タスク実装
  1. プルリクエスト
  1. コードレビュー
  1. GitHub 上でマージ
  1. Close

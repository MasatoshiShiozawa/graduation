# README

# 株主優待.com

## 概要
株主優待から株を探せる。<br>
投資の参考材料として、割安/割高を示すPERと割安・並・割高のアイコン、100株の取得価格を表示する。
サイト運営者への収益は、広告掲載、証券会社からの手数料により行う。当サイトを踏むことなく株の取得を行われないよう、大手（dポイント、Tポイントなどを想定）のポイントを付与をできるようにする

## コンセプト
株主優待の切り口から、株式投資を身近に感じてもらい、特に20代前半の株式投資を促したい。

## バージョン
Ruby 2.6.5
Rails 5.2.4.4

## 機能一覧
□ログイン機能【高】
□ユーザー登録機能【高】
　□メールアドレス、名前、パスワード、ポイント選択は必須
□会員情報再設定機能【高】
□優待一覧表示機能
　□写真を表示【高】
　□解説を表示【高】
　□お気に入り数を表示【中】
　□会員のうちの購入者数を表示【中】
　□割安/割高を示すPERと割安・並・割高のアイコン、100株の取得価格を表示【高】
　□東証の株価DBとAPI連携し、リアルタイムの株価（100株の取得価格）を表示【低】
□優待投稿機能（サイト運営者のみ登録可能）
　□写真、解説は必須【高】
□優待編集機能（サイト運営者のみ登録可能）【高】
□優待削除機能（サイト運営者のみ登録可能）【高】
□優待お気に入り機能【高】
　□優待のお気に入りについては1つのブログに対して1人1回しかできない【高】
□優待に対するコメント投稿機能【高】
□優待に対するコメント削除機能【高】
□優待に対するコメント編集機能【高】
　□優待編集・削除はコメントした本人のみ可能【高】
□コメント機能とお気に入り機能についてはページ遷移なしで実行できる【高】

## テーブル定義、ER図
https://drive.google.com/file/d/1eDe_OFLUGY6n3YEm33Hc-_hkK6_qnHxZ/view?usp=sharing

## 画面遷移図
https://drive.google.com/file/d/1nMCsOOlqgbxdDRq2Bb3cANXGX4KgN39n/view?usp=sharing

## 画面ワイヤーフレーム
https://drive.google.com/file/d/1rFK3P-VOjw_EF4zcT5DBqHVy3tkIkwgF/view?usp=sharing

## 使用予定Gem
* carrierwave
* mini_magick
* gem 'faker'
* devise
* kaminari

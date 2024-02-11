# frozen_string_literal: true

require_relative 'lib/tweet_client'
require_relative 'lib/fetch_ranking'

DEBUG_MODE = false

# イベント開催期間が3/31 23:59なのでそれ以降は出力しない
raise 'period error!' if Time.now > Time.parse('2024.4.1')

MESSAGE_HASH = {
  1..1 => [
    'わーい！プレーキャラランキング%d位だよ！みんなありがとー！！',
    'わーい！プレーキャラランキング%d位だよ！ボクたちが１番だよ'
  ],
  2..5 => [
    'プレーキャラランキング%d位だよ！1位までがんばりたいな',
    'プレーキャラランキング%d位だよ！あとすこしだよ',
    'プレーキャラランキング%d位だよ！いい調子だよ'
  ],
  6..10 => [
    'プレーキャラランキング%d位だよ！いい調子だよ',
    'プレーキャラランキング%d位だよ！誰にも負けないよ',
    'プレーキャラランキング%d位だよ！頑張るよ'
  ],
  11..15 => [
    'プレーキャラランキング%d位だよ！これからが本当の戦いだよ',
    'プレーキャラランキング%d位だよ！うん、よろしくね',
    'プレーキャラランキング%d位だよ！よーし、負けないぞ'
  ],
  16..99 => [
    'プレーキャラランキング%d位だよ。プレーお願いします',
    'プレーキャラランキング%d位だよ。むーっ、次こそはボクが',
    'プレーキャラランキング%d位だよ。まだまだがんばらなきゃ'
  ]
}.freeze

def build_message(ranking:)
  message = MESSAGE_HASH.find { |key, _hash| key.include?(ranking) }.last.sample
  message = format(message, ranking)
  "#{message} https://p.eagate.573.jp/game/qma/18/ranking/chara.html?rid=310000"
end

ranking = FetchRanking.new.fetch_by(name: 'ユウ')
message = build_message(ranking:)

TweetClient.new.post(message)

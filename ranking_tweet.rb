# frozen_string_literal: true

require_relative 'lib/tweet_client'
require_relative 'lib/fetch_ranking'

DEBUG_MODE = false

# イベント開催期間が3/31 23:59なのでそれ以降は出力しない
raise 'period error!' if Time.now > Time.parse('2024.4.1')

MESSAGE_HASH = {
  1..1 => [
    'やったー！プレーキャラランキング%d位だよ！みんなありがとー！！',
    'わーい！プレーキャラランキング%d位だよ！やったぁ、嬉しいなぁ！'
  ],
  2..5 => [
    'プレーキャラランキング%d位だよ！わーい、わーい！',
    'プレーキャラランキング%d位だよ！1位までもうちょっとなのにぃ',
    'プレーキャラランキング%d位だよ！うれしいな。うれしいな！'
  ],
  6..10 => [
    'プレーキャラランキング%d位だよ！うん、がんばるよ！',
    'プレーキャラランキング%d位だよ！もっと勉強しなくちゃ',
    'プレーキャラランキング%d位だよ！次は負けないもん！'
  ],
  11..15 => [
    'プレーキャラランキング%d位だよ！次は1位を狙うんだもん！',
    'プレーキャラランキング%d位だよ！負けないもーん',
    'プレーキャラランキング%d位だよ！いってきまーす'
  ],
  16..99 => [
    'プレーキャラランキング%d位だよ。い、いじめないね？',
    'プレーキャラランキング%d位だよ。負けても泣かないもん！',
    'プレーキャラランキング%d位だよ。みんなで頑張ろうね'
  ]
}.freeze

def build_message(ranking:)
  message = MESSAGE_HASH.find { |key, _hash| key.include?(ranking) }.last.sample
  message = format(message, ranking)
  "#{message} https://p.eagate.573.jp/game/qma/18/ranking/chara.html?rid=310000"
end

ranking = FetchRanking.new.fetch_by(name: 'アロエ')
message = build_message(ranking:)

TweetClient.new.post(message)

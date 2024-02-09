# frozen_string_literal: true

require_relative 'lib/tweet_client'
require_relative 'lib/fetch_ranking'

DEBUG_MODE = false

# イベント開催期間が3/31 23:59なのでそれ以降は出力しない
raise 'period error!' if Time.now > Time.parse('2024.4.1')

def tweet_message(ranking:)
  message = case ranking
            when 1
              'わーい！プレーキャラランキング1位だよ！みんなありがとー！！'
            when 2..10
              format('プレーキャラランキング%d位だよ！1位までがんばりたいな', ranking)
            when 11..99
              format('プレーキャラランキング%d位だよ。まだまだがんばらなきゃ', ranking)
            end
  "#{message} https://p.eagate.573.jp/game/qma/18/ranking/chara.html?rid=310000"
end

ranking = FetchRanking.new.fetch_by(name: 'ユウ')
message = tweet_message(ranking:)

TweetClient.new.post(message)

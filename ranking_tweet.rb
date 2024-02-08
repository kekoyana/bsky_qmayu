# frozen_string_literal: true

require_relative 'lib/tweet_client'
require_relative 'lib/fetch_ranking'

def tweet_message(ranking:)
  case ranking
  when 1
    'わーい！プレーキャラランキング1位だよ！みんなありがとー！！'
  when 2..10
    'プレーキャラランキング%d位だよ！1位までがんばりたいな' % ranking
  when 11..99
    'プレーキャラランキング%d位だよ。まだまだがんばらなきゃ' % ranking
  end
end

ranking = FetchRanking.new.fetch_by(name: 'ユウ')
message = tweet_message(ranking:)

puts message
# TweetClient.new.post(message)

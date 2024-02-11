# frozen_string_literal: true

require 'yaml'
require_relative 'lib/tweet_client'

DEBUG_MODE = false

messages = YAML.load_file("./message.yaml")
tweets = messages.values_at("qma2","qma3","qma4","qma5","qma6","qma7","qma8").flatten

message = tweets.sample

# 1/1限定
message = '今日は誕生日だもん！' if Time.now.strftime('%m%d') == '0101' && rand < 0.6

TweetClient.new.post(message)

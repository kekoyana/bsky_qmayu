# frozen_string_literal: true

require_relative 'lib/tweet_client'

DEBUG_MODE = false

tweets = [
  '後ろの人なんていないよ',
  'いつでもいーよ',
  'ボクたちが１番だよ',
  '悪くないねー',
  'に゛ゃああああっ',
  'これからが本当の戦いだよ！',
  'ボクだけだ！',
  'えーっ、ボクだけー？！',
  '今度はボクが勝つんだ！',
  'うん、いい調子！',
  '苦手ジャンルを無くしたいなぁ',
  'ま・た・こ・ん・ど♪',
  'わーい、合格ぅ！',
  'やったー、トップだ！',
  'いい調子だよ！',
  'むーっ、次こそは僕が！',
  '誰にも負けないよ！',
  'だめだったぁ',
  'お願いしまーす！',
  '教室にもどろっ！',
  'ボク、オトコのコ…だよ……',
  'ボク、オトコのコ…だよ……',
  'ボク、男の娘…だよ……',
  'ボク、男の娘…だよ……',
  'ボク、男の娘…だよ……',
  'ボク、女の子…だよ……',
  'もうだめらぁ',
  'えへっ、いい気分だね！',
  'もっともっといくんだ！',
  'ついに僕も賢者だよ　お姉ちゃん！',
  'わぁー!ごはんあげるの忘れてた。ごめんねー',
  '僕と勝負しよ！',
  'よーし、いってきまーす！',
  '抱いて？用事ってなあに？',
  'エターナルライト！'
]

message = tweets.sample

# 3/3は誕生日ツイートで上書き
message = 'ボク、誕生日…だよ……' if Time.now.strftime('%m%d') == '0303' && rand < 0.6

TweetClient.new.post(message)

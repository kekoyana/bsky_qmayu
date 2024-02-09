# frozen_string_literal: true

require_relative 'lib/article_fetcher'
require_relative 'lib/tweet_client'

DEBUG_MODE = false
LAST_ID_FILE = File.expand_path('news_last_id', __dir__)
NEWS_TEMPLATE = <<~TEMPLATE
  【QMAニュース】
  %<title>s

  %<url>s
TEMPLATE

recent_id = File.exist?(LAST_ID_FILE) ? File.read(LAST_ID_FILE).to_i : 0
fetcher = ArticleFetcher.new

articles = fetcher.articles_from_last_id(recent_id)

# DEBUG用
# articles.each { puts _1 }

articles.reverse.each do |article|
  message = NEWS_TEMPLATE % { title: article.title, url: article.url }
  message.strip!
  TweetClient.new.post(message)
end

File.write(LAST_ID_FILE, fetcher.last_id)

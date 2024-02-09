# frozen_string_literal: true

require_relative 'lib/article_fetcher'

DEBUG_MODE = true

articles = ArticleFetcher.new.fetch_articles
articles.each { puts _1 }

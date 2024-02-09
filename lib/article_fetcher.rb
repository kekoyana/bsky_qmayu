# frozen_string_literal: true

require 'open-uri'
require 'nokogiri'
require_relative 'article'

class ArticleFetcher
  SAMPLE_FILE = './sample.html'
  NEWS_URL = Article::NEWS_URL

  def articles
    @articles ||= fetch_articles
  end

  def last_id
    articles.max_by(&:id).id
  end

  def articles_from_last_id(arg_id)
    articles.filter { _1.id > arg_id }
  end

  private

  def fetch_articles
    fetch_elements.map do |element|
      Article.convert_by_element(element:)
    end
  end

  def fetch_elements
    html = DEBUG_MODE ? file_doc : fetch_doc
    doc = Nokogiri::HTML5(html, NEWS_URL, 'utf-8')
    main_box = doc.at_css('.main#notice, .main_box')
    main_box.css('ul.list')
  end

  def file_doc
    File.read(SAMPLE_FILE)
  end

  def fetch_doc
    URI.open(NEWS_URL).read
  end
end

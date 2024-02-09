# frozen_string_literal: true

class Article
  NEWS_URL = 'https://p.eagate.573.jp/game/qma/18/info/index.html'
  attr_accessor :id, :date, :title, :body, :url

  def self.convert_by_element(element:)
    new.tap do |article|
      article.id = element.at_css('li').attr('id')
      article.date_by_element(element:)
      article.title_by_element(element:)
      article.url_by_element(element:)
    end
  end

  def date_by_element(element:)
    date_text = element.at_css('dt')&.text || element.at_css('li').attr('id')
    self.date = Date.parse(date_text)
  end

  def title_by_element(element:)
    if element.at_css('.title')
      self.title = element.at_css('.title').text.strip
    else
      self.title = element.at_css('dd').text.strip
      self.body = element.at_css('div')&.text&.strip
    end
  end

  def url_by_element(element:)
    alink = element.at_css('a')
    if alink
      link = alink.attribute('href').value
      link = "http://p.eagate.573.jp#{link}" unless link.start_with?('http')
      self.url = link
    end
    self.url ||= NEWS_URL + "##{@id}"
  end

  def to_s
    "#{@date} #{@title} #{@url}"
  end
end
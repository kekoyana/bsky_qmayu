# frozen_string_literal: true

require 'open-uri'
require 'nokogiri'

class FetchRanking
  RANKING_URL = 'https://p.eagate.573.jp/game/qma/18/ranking/chara.html?rid=310000'

  def fetch_by(name:)
    raise 'invalid name' unless %w[ユウ アロエ].include?(name)

    doc = fetch_doc(name:)
    raise 'Ranking not found.' if doc.nil?

    doc.at_css('li').text.to_i.tap do |ranking|
      raise 'Ranking zero.' if ranking.zero?
    end
  end

  def fetch_doc(name:)
    html = URI.open(RANKING_URL).read
    doc = Nokogiri::HTML(html, RANKING_URL)

    doc.css('ul.ranking_s').find do |ul|
      ul.at_css('p').text == name
    end
  end
end

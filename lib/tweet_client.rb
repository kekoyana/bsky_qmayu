# frozen_string_literal: true

require 'bskyrb'

class TweetClient
  USERNAME = 'qmayu.bsky.social'
  PASSWORD = ENV.fetch('BSKYB_QMAYU_PASSWORD', nil)
  PDS_URL = 'https://bsky.social'

  LINK_PATTERN = %r{(https?://\S+)}

  def post(message)
    raise 'no setting password.' if PASSWORD.to_s.empty?

    credentials = Bskyrb::Credentials.new(USERNAME, PASSWORD)
    session = Bskyrb::Session.new(credentials, PDS_URL)
    bsky = Bskyrb::RecordManager.new(session)

    puts "Tweet:#{message}"
    data = build_data(session:, message:)
    bsky.create_record(data) unless DEBUG_MODE
  end

  private

  def build_data(session:, message:)
    {
      'collection' => 'app.bsky.feed.post',
      'repo' => session.did,
      'record' => {
        '$type' => 'app.bsky.feed.post',
        'createdAt' => Time.now.iso8601(3),
        'text' => message,
        'facets' => build_facets(message:)
      }
    }
  end

  def build_facets(message:) # rubocop:disable Metrics/MethodLength
    match = message.match(LINK_PATTERN)
    return [] unless match

    index_start, index_end = match.byteoffset(0)
    [
      {
        '$type' => 'app.bsky.richtext.facet',
        'index' => {
          'byteStart' => index_start,
          'byteEnd' => index_end
        },
        'features' => [
          {
            'uri' => match.to_s,
            '$type' => 'app.bsky.richtext.facet#link'
          }
        ]
      }
    ]
  end
end

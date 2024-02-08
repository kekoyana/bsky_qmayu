require 'bskyrb'

class TweetClient
  USERNAME = 'qmayu.bsky.social'
  PASSWORD = ENV['BSKYB_QMAYU_PASSWORD']
  PDS_URL = 'https://bsky.social'

  def post(message)
    raise 'no setting password.' if PASSWORD.to_s.empty?

    credentials = Bskyrb::Credentials.new(USERNAME, PASSWORD)
    session = Bskyrb::Session.new(credentials, PDS_URL)
    bsky = Bskyrb::RecordManager.new(session)
    bsky.create_post(message)
  end
end

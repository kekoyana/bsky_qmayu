require 'bskyrb'
username = 'qmayu.bsky.social'
password = ENV['BSKYB_QMAYU_PASSWORD']
pds_url = 'https://bsky.social'

credentials = Bskyrb::Credentials.new(username, password)
session = Bskyrb::Session.new(credentials, pds_url)
bsky = Bskyrb::RecordManager.new(session)

bsky.create_post('ボク、オトコのコ…だよ……')

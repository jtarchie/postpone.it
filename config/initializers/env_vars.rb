['FACEBOOK_APP_ID', 'FACEBOOK_APP_SECRET',
 'TWITTER_CONSUMER_SECRET', 'TWITTER_CONSUMER_KEY',
 'YOUTUBE_CONSUMER_SECRET', 'YOUTUBE_CONSUMER_KEY',
 'VIMEO_CONSUMER_SECRET', 'VIMEO_CONSUMER_KEY',
].each do |value|
  raise "The config variable #{value} has not been set for the #{Rails.env} environment." if ENV[value.to_s].blank?
end
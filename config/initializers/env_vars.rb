['FACEBOOK_APP_ID', 'FACEBOOK_APP_SECRET'].each do |value|
  raise "The config variable #{value} has not been set for the #{Rails.env} environment." if ENV[value.to_s].blank?
end
Then /^I should have been authorized with "([^"]*)"$/ do |provider|
  user = User.where(:email => DEFAULT_USERNAME).first
  user.authorizations.where(:provider => provider.underscore).size.should > 0
end

And /^redirect back to the "([^"]*)" provider$/ do |provider|
  visit "/users/auth/#{provider.underscore}/callback"
end

And /^we stub out Facebook$/ do
  FACEBOOK_API_BASE = 'https://graph.facebook.com/'
  FakeWeb.register_uri(:post, FACEBOOK_API_BASE + 'oauth/access_token',
                       :body => {
                       :access_token => "faketoken"
                       }.to_json)
  FakeWeb.register_uri(:get, FACEBOOK_API_BASE + 'me?access_token=faketoken',
                       :body => {
                       :id => '12345',
                       :link => 'http://facebook.com/user_example',
                       :email => DEFAULT_USERNAME,
                       :first_name => 'John',
                       :last_name => 'Doe',
                       :website => 'http://blog.plataformatec.com.br'
                       }.to_json)
end

And /^we stub out Twitter$/ do
  TWITTER_API_BASE = 'https://api.twitter.com/'

  FakeWeb.register_uri(:post, TWITTER_API_BASE + 'oauth/request_token',
                       :body => 'oauth_token=fake'
  )
  FakeWeb.register_uri(:post, TWITTER_API_BASE + 'oauth/access_token',
                       :body => 'oauth_token=fake&oauth_token_secret=fake'
  )
  FakeWeb.register_uri(:get,
                       TWITTER_API_BASE + '1/account/verify_credentials.json',
                       :body => {
                         :screen_name => "johnsmith",
                         :name => "John Smith",
                         :location => "San Francisco",
                         :url => "http://example.com"
                       }.to_json
  )
end

And /^we stub out Vimeo$/ do
  VIMEO_API_BASE = 'http://vimeo.com/'

  FakeWeb.register_uri(:post, VIMEO_API_BASE + 'oauth/request_token',
                       :body => 'oauth_token=fake'
  )
  FakeWeb.register_uri(:post, VIMEO_API_BASE + 'oauth/access_token',
                       :body => 'oauth_token=fake&oauth_token_secret=fake'
  )
  FakeWeb.register_uri(:get, VIMEO_API_BASE + 'api/rest/v2?method=vimeo.people.getInfo&format=json',
                       :body => { :person => {
                       :username => "johnsmith",
                       :display_name => "John Smith",
                       :location => "San Francisco",
                       :url => "http://example.com",
                       :portraits => {
                       :portrait => [{:height => '300', "_content" => ""}]
                       }}
                       }.to_json
  )
end

And /^we stub out YouTube$/ do
  YOUTUBE_API_BASE = 'https://www.google.com/'

  FakeWeb.register_uri(:post, YOUTUBE_API_BASE + 'accounts/OAuthGetRequestToken',
                       :body => 'oauth_token=fake'
  )
  FakeWeb.register_uri(:post, YOUTUBE_API_BASE + 'accounts/OAuthGetAccessToken',
                       :body => 'oauth_token=fake&oauth_token_secret=fake'
  )
  FakeWeb.register_uri(:get, 'http://gdata.youtube.com/feeds/api/users/default?alt=json',
                       :body => {
                        :entry => {
                          'id' => {},
                          'author' => [{'name'=>{}}],
                          'yt$firstName' => '',
                          'yt$lastName' => '',
                          'media$thumbnail' => '',
                          'yt$description' => '',
                          'yt$location' => ''
                        }
                       }.to_json
  )
end

And /^we authorize with "([^"]*)"$/ do |provider|
  And "we stub out #{provider}"
  When "I follow \"#{provider}\""
  And "redirect back to the \"#{provider}\" provider"
end
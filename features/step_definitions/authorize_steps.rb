Then /^I should have been authorized with "([^"]*)"$/ do |provider|
  user = User.where(:email => DEFAULT_USERNAME).first
  user.authorizations.where(:provider => provider.underscore).size.should > 0
end

And /^redirect back to the "([^"]*)" provider$/ do |provider|
  visit "/users/auth/#{provider.underscore}/callback"
end

And /^we stub out Facebook$/ do
  stub_request(:post, "https://graph.facebook.com/oauth/access_token").
    to_return(:body => {
                       :access_token => "faketoken"
                       }.to_json)
  stub_request(:get, "https://graph.facebook.com/me?access_token=faketoken").
  to_return(:body => {
                       :id => '12345',
                       :link => 'http://facebook.com/user_example',
                       :email => DEFAULT_USERNAME,
                       :first_name => 'John',
                       :last_name => 'Doe',
                       :website => 'http://blog.plataformatec.com.br'
                       }.to_json)
end

And /^we stub out Twitter$/ do
  stub_request(:post, "https://api.twitter.com/oauth/request_token").
  to_return(:status => 200, :body => "oauth_token=fake")
  stub_request(:post, "https://api.twitter.com/oauth/access_token").
  to_return(:status => 200, :body => "oauth_token=fake&oauth_token_secret=fake")
  stub_request(:get, "https://api.twitter.com/1/account/verify_credentials.json").
  to_return(:status => 200, :body => {
                         :screen_name => "johnsmith",
                         :name => "John Smith",
                         :location => "San Francisco",
                         :url => "http://example.com"
                       }.to_json)
end

And /^we stub out Vimeo$/ do
  VIMEO_API_BASE = 'http://vimeo.com/'

  stub_request(:post, "http://vimeo.com/oauth/request_token").
  to_return(:status => 200, :body => "oauth_token=fake")
  stub_request(:post, "http://vimeo.com/oauth/access_token").
  to_return(:status => 200, :body => "oauth_token=fake&oauth_token_secret=fake")
  stub_request(:get, "http://vimeo.com/api/rest/v2?format=json&method=vimeo.people.getInfo").
  to_return(:status => 200, :body => { :person => {
                       :username => "johnsmith",
                       :display_name => "John Smith",
                       :location => "San Francisco",
                       :url => "http://example.com",
                       :portraits => {
                       :portrait => [{:height => '300', "_content" => ""}]
                       }}
                       }.to_json)
end

And /^we stub out YouTube$/ do
  YOUTUBE_API_BASE = 'https://www.google.com/'

  stub_request(:post, "https://www.google.com/accounts/OAuthGetRequestToken").
  to_return(:status => 200, :body => "oauth_token=fake")
  stub_request(:post, "https://www.google.com/accounts/OAuthGetAccessToken").
  to_return(:status => 200, :body => "oauth_token=fake&oauth_token_secret=fake")
  stub_request(:get, "http://gdata.youtube.com/feeds/api/users/default?alt=json").
  to_return(:status => 200, :body => {
                        :entry => {
                          'id' => {},
                          'author' => [{'name'=>{}}],
                          'yt$firstName' => '',
                          'yt$lastName' => '',
                          'media$thumbnail' => '',
                          'yt$description' => '',
                          'yt$location' => ''
                        }
                       }.to_json)
end

And /^we authorize with "([^"]*)"$/ do |provider|
  And "we stub out #{provider}"
  When "I follow \"#{provider}\""
  And "redirect back to the \"#{provider}\" provider"
end
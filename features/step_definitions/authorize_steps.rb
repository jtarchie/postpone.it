Then /^I should have been authorized with "([^"]*)"$/ do |provider|
  user = User.where(:email => DEFAULT_USERNAME).first
  user.authorizations.where(:provider => provider.downcase).size.should > 0
end

And /^redirect back to the Facebook provider$/ do
  Devise::OmniAuth.stub!(:facebook) do |b|
    b.post('/oauth/access_token') { [200, {}, {
      :access_token => "faketoken"
    }.to_json] }
    b.get('/me?access_token=faketoken') { [200, {}, {
      :id => '12345',
      :link => 'http://facebook.com/user_example',
      :email => DEFAULT_USERNAME,
      :first_name => 'John',
      :last_name => 'Doe',
      :website => 'http://blog.plataformatec.com.br'
    }.to_json] }
  end

  visit "/users/auth/facebook/callback"
end

And /^redirect back to the Twitter provider$/ do
  visit "/users/auth/twitter/callback"
end

And /^we stub out Omniauth$/ do
  Devise::OmniAuth.short_circuit_authorizers!

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
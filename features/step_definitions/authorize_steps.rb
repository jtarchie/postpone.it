Then /^I should have been authorized with "([^"]*)"$/ do |arg1|
  user = User.where(:email => DEFAULT_USERNAME).first
  user.authorizations.where(:provider => "facebook").size.should > 0
end

And /^redirect back to the Facebook provider$/ do
  Devise::OmniAuth.short_circuit_authorizers!
  Devise::OmniAuth.stub!(:facebook) do |b|
    b.post('/oauth/access_token') { [200, {}, {
      :access_token => "plataformatec"
    }.to_json] }
    b.get('/me?access_token=plataformatec') { [200, {}, FACEBOOK_INFO = {
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
And /^"([^\"]*)" has a video$/ do |username|
  user = User.where(:email => username).first
  Factory(:video, :user => user)
end

And /^I have a video$/ do
  And %{"#{DEFAULT_USERNAME}" has a video}
end
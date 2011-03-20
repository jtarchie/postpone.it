FixtureBuilder.configure do |builder|
  builder.files_to_check += ["spec/support/factories.rb", "spec/support/fixture_builder.rb"]

  builder.factory do
    user = Factory(:user)
    builder.name(:user, user)
    builder.name(:video, Factory(:video, :user => user))
    builder.name(:other_video, Factory(:video))
  end
end
FixtureBuilder.configure do |builder|
  builder.files_to_check += ["spec/support/factories.rb", "spec/support/fixture_builder.rb"]

  builder.factory do
    builder.name(:user, Factory(:user))
  end
end
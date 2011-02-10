Factory.define :user do |u|
  u.email {Faker::Internet.email}
  u.password {"password"}
end
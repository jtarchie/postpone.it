Factory.define :user do |u|
  u.email {Faker::Internet.email}
  u.password {"password"}
end

Factory.define :authorization do |a|
  a.provider "provider"
  a.uid "uid"
  a.association :user
end
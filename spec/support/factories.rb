Factory.define :user do |u|
  u.email {Faker::Internet.email}
  u.password {"password"}
end

Factory.define :authorization do |a|
  a.provider "provider"
  a.uid "uid"
  a.association :user
end

Factory.define :video do |v|
  v.title "Video"
  v.description "A video with some content"
  v.url "http://example.com/video.mov"
  v.association :user
end
Factory.define :user do |f|
  f.name 'David Rotenmeier'
  f.nickname 'zapnap'
end

Factory.define :authentication do |f|
  f.provider 'twitter'
  f.uuid 12345
  f.association :user
end
  
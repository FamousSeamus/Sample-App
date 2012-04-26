Factory.define :user do |user|
  user.name                   "Sean Musick"
  user.email                  "sean@atebitebite.com"
  user.password               "foobar"
  user.password_confirmation  "foobar"
end

Factory.sequence :email do |n|
  "person-#{n}@example.com"
end
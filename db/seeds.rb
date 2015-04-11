# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.create! :first => 'Bob', :last => 'Dylan', :email => 'bobdylan@yahoo.com', :admin => true, :password => '1qaz!QAZ', :password_confirmation => '1qaz!QAZ'
user = User.create! :first => 'One', :last => 'User', :email => 'user1@yahoo.com', :password => '1qaz!QAZ', :password_confirmation => '1qaz!QAZ'
user = User.create! :first => 'Two', :last => 'User', :email => 'user2@yahoo.com', :password => '1qaz!QAZ', :password_confirmation => '1qaz!QAZ'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(username: 'marcin1', email: '1@gmail.com', password: 'password', password_confirmation: 'password')
User.create(username: 'marcin2', email: '2@gmail.com', password: 'password', password_confirmation: 'password')
User.create(username: 'marcin3', email: '3@gmail.com', password: 'password', password_confirmation: 'password')
User.create(username: 'marcin4', email: '4@gmail.com', password: 'password', password_confirmation: 'password')
User.create(username: 'marcin5', email: '5@gmail.com', password: 'password', password_confirmation: 'password')

p 'Test user created'
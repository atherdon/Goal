# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: 'test@gmail.com', password: '123456789')

10.times{|n|
  Task.create( title: Faker::Book.title,
                  description: Faker::Company.catch_phrase,
                  user_id: User.last().id,
                  due_date: DateTime.now() + 1.hour,
                  priority:  1
                )
}
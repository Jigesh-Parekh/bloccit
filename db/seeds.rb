# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


require "random_data"


5.times do
	User.create!(
		name:  RandomData.random_name,
		email: RandomData.random_email,
		password: RandomData.random_sentence
		)
end

users = User.all

user = User.first
user.update_attributes!(
   email: 'jiggyfr3sh@gmail.com', # replace this with your personal email
   password: '123456'
 )



15.times do
	Topic.create!(
		name: RandomData.random_sentence,
		description: RandomData.random_paragraph)
end
topics = Topic.all


50.times  do
    #! instructs the method to raise an error if there is a problem
    #with the data we are seeding without bang can fail without warnging
	Post.create!(
		user: users.sample,
		topic: topics.sample,
		title: RandomData.random_sentence,
		body:  RandomData.random_paragraph
		)

end

post = Post.all

100.times do 
	Comment.create!(
		post: post.sample,
		body: RandomData.random_paragraph
		)
end

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Topic.count} topics created"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"
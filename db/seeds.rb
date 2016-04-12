# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


require "random_data"

50.times  do
    #! instructs the method to raise an error if there is a problem
    #with the data we are seeding without bang can fail without warnging
	Post.create!(
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

5.times do
	Advertisement.create!(
		title: RandomData.random_sentence,
		body: RandomData.random_paragraph,
		price: 0
		)
end

advertisements = Advertisement.all

puts "Seed finished"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"
puts "#{Advertisement.count} ads created"
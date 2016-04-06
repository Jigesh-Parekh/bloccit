require 'rails_helper'

RSpec.describe Post, type: :model do
	#let method create new instance of post class and name it post
	#let - dynamically defines a method - it block computes and stores the returned value
  let(:post) { Post.create!(title: "New Post Title", body: "New Post Body")}
  #test post has attributes named title and body
  describe "attributes" do
  	it "has a title and body attributes" do
  		expect(post).to have_attributes(title: "New Post Title", body: "New Post Body")
  	end
  end
end

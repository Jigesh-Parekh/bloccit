require 'rails_helper'

RSpec.describe Post, type: :model do
	#let method create new instance of post class and name it post
	#let - dynamically defines a method - it block computes and stores the returned value
    let(:name) { RandomData.random_sentence }
    let(:description) { RandomData.random_paragraph }
    let(:title) { RandomData.random_sentence }
    let(:body) { RandomData.random_paragraph }

    let(:topic){ Topic.create!(name: name, description: description)}

    let(:post) {topic.posts.create!(title:title, body:body)}

    it { is_expected.to belong_to(:topic)}

    it { is_expected.to validate_presence_of(:title)}
    it { is_expected.to validate_presence_of(:body)}
    it { is_expected.to validate_presence_of(:topic)}

    it { is_expected.to validate_length_of(:title).is_at_least(5)}
    it { is_expected.to validate_length_of(:body).is_at_least(20)}
  #test post has attributes named title and body
  describe "attributes" do
  	it "has a title and body attributes" do
  		expect(post).to have_attributes(title: title, body: body)
  	end
  end
end

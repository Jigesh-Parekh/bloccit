require 'rails_helper'

RSpec.describe Question, type: :model do
  let(:question) {Question.create!(title: "Question", body: "Who is God?")}
  describe "attributes" do
  	it "Question has title and question body" do
  		expect(question).to have_attributes(title: "Question", body: "Who is God?")
  	end
  end
end

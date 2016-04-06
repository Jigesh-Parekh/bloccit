require 'rails_helper'

RSpec.describe Answer, type: :model do
  let(:question) {Question.create!(title: "Question", body: "Who is God?")}
  let(:answer) {Answer.create!(body: "42", question: question)}

  describe "attributes" do
  	it "has a body" do
  		expect(answer).to have_attributes(body: "42")
  	end
  end
end

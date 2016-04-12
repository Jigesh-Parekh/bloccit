require 'rails_helper'

RSpec.describe Advertisement, type: :model do
	let(:advertisement) {Advertisement.create! }

    describe "attributes" do
  	it "Ad has a title attribute" do
  		expect(advertisement).to respond_to(:title) 
  	end

  	it "Ad has a body attribute" do
  		expect(advertisement).to respond_to(:body) 
  	end

  	it "Ad has a price attribute" do
  		expect(advertisement).to respond_to(:price) 
  	end
  end
end

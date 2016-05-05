 require 'rails_helper'
 include RandomData
 
 RSpec.describe Api::V1::PostsController, type: :controller do
   let(:my_user) { create(:user) }
   let(:my_topic) { create(:topic) }
   let(:my_post) {create(:post, topic: my_topic, user: my_user)}
   let(:my_comment) {Comment.create!(body: RandomData.random_paragraph, post: my_post, user: my_user)}
 
 # #20
   context "unauthenticated user" do
     it "GET index returns http success" do
       get :index
       expect(response).to have_http_status(:success)
     end
 
     it "GET show returns http success" do
       get :show, id: my_comment.id
       expect(response).to have_http_status(:success)
     end

     it "GET show returns a comments" do
      get :show, id: my_comment.id
      response_hash = JSON.parse response.body
      expect(response_hash['id']).to eq my_comment.id
    end
   end
 
   context "unauthorized user" do
     before do
       controller.request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(my_user.auth_token)
     end
 
 
     it "GET index returns http success" do
       get :index
       expect(response).to have_http_status(:success)
     end
 
     it "GET show returns http success" do
       get :show, id: my_comment.id
       expect(response).to have_http_status(:success)
     end

     it "GET show returns child comments" do
      get :show, id: my_comment.id
      response_hash = JSON.parse response.body
      expect(response_hash['comments']).to_not be_nil 
     end
   end

 end
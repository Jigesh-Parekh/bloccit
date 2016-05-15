 require 'rails_helper'
 
 RSpec.describe Api::V1::TopicsController, type: :controller do
   let(:my_user) { create(:user) }
   let(:my_topic) { create(:topic) }
 
 # #20
   context "unauthenticated user" do
     it "GET index returns http success" do
       get :index
       expect(response).to have_http_status(:success)
     end
 
     it "GET show returns http success" do
       get :show, id: my_topic.id
       expect(response).to have_http_status(:success)
     end

     it "PUT update returns http unauthenticated" do 
      put :update, id: my_topic.id, topic: {name: "Topic name", description: "Topic Description"}
      expect(response).to have_http_status(401)
    end

    it "POST create retruns http unauthenticated" do
      put :create, topic: {name: "Topic Name", description: "Topic Description"}
      expect(response).to have_http_status(401)
    end

    it "DELETE destroy returns http unauthenticated" do
      delete :destroy, id: my_topic.id
      expect(response).to have_http_status(401)
    end
   end
 
   context "unauthorized user" do

     before do
       controller.request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(my_user.auth_token)
     end
 
 # #21
     it "GET index returns http success" do
       get :index
       expect(response).to have_http_status(:success)
     end
 
     it "GET show returns http success" do
       get :show, id: my_topic.id
       expect(response).to have_http_status(:success)
     end

     it "PUT update returns http forbidden" do
       put :update, id: my_topic.id, topic: {name: "Topic Name", description: "Topic Description"}
       expect(response).to have_http_status(403)
     end
 
     it "POST create returns http forbidden" do
       post :create, topic: {name: "Topic Name", description: "Topic Description"}
       expect(response).to have_http_status(403)
     end
 
     it "DELETE destroy returns http forbidden" do
       delete :destroy, id: my_topic.id
       expect(response).to have_http_status(403)
     end
   end

   context "authenticated and authorized users" do
 # #16
     before do
       my_user.admin!
       controller.request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(my_user.auth_token)
       @new_topic = build(:topic)
     end
 
     describe "PUT update" do
       before { put :update, id: my_topic.id, topic: {name: @new_topic.name, description: @new_topic.description} }
 
       it "returns http success" do
         expect(response).to have_http_status(:success)
       end
 
       it "returns json content type" do
         expect(response.content_type).to eq 'application/json'
       end
 
 # #17
       it "updates a topic with the correct attributes" do
         updated_topic = Topic.find(my_topic.id)
         expect(response.body).to eq(updated_topic.to_json)
       end
     end

     describe "POST create" do
       before { post :create, topic: {name: @new_topic.name, description: @new_topic.description} }
 
       it "returns http success" do
         expect(response).to have_http_status(:success)
       end
 
       it "returns json content type" do
         expect(response.content_type).to eq 'application/json'
       end
 
       it "creates a topic with the correct attributes" do
         hashed_json = JSON.parse(response.body)
         expect(hashed_json["name"]).to eq(@new_topic.name)
         expect(hashed_json["description"]).to eq(@new_topic.description)
       end
     end

     describe "DELETE destroy" do
       before { delete :destroy, id: my_topic.id }
 
 # #18
       it "returns http success" do
         expect(response).to have_http_status(:success)
       end
 
       it "returns json content type" do
         expect(response.content_type).to eq 'application/json'
       end
 
       it "returns the correct json success message" do
         expect(response.body).to eq({ message: "Topic destroyed", status: 200 }.to_json)
       end
 
       it "deletes my_topic" do
 # #19
         expect{ Topic.find(my_topic.id) }.to raise_exception(ActiveRecord::RecordNotFound)
       end
     end
   end
 end
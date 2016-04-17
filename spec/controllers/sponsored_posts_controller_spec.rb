require 'rails_helper'
RSpec.describe SponsoredPostsController, type: :controller do
#8

  let(:my_topic) {Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph)}

  let(:my_spon_post) {my_topic.sponsoredposts.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph)}

 


#10  get new is invoked new unsaved post obj is created
#when create is invoked new object is persisted to database
#mimics RESTful parts of HTTP
  describe "GET new" do
    it "returns http success" do
      get :new, topic_id: my_topic.id
      expect(response).to have_http_status(:success)
    end
#12
    it "renders the #new view" do
      get :new, topic_id: my_topic.id
      expect(response).to have_http_status(:success)
    end
#13
    it "instatinates @post" do
      get :new, topic_id: my_topic.id
      expect(assigns(:sponsoredpost)).not_to be_nil
    end
  end

  describe "POST create" do
#14 
     it "increases the number of Post by 1" do
        expect{post :create, topic_id: my_topic.id, post: {title: RandomData.random_sentence, body: RandomData.random_paragraph}}.to change(SponsoredPost,:count).by(1)
      end
 

    it "assigns the new post to @post" do
        post :create, topic_id: my_topic.id, post: {title: RandomData.random_sentence, body: RandomData.random_paragraph}
        expect(assigns(:sponsoredpost)).to eq Post.last
    end

    it "redirects to the new post" do
      post :create, topic_id: my_topic.id, post: {title: RandomData.random_sentence, body: RandomData.random_paragraph}
      expect(response).to redirect_to [my_topic, SponsoredPost.last]
    end
  end

   describe "GET show" do
     it "returns http success" do
 # #16
       get :show, topic_id: my_topic.id, id: my_spon_post.id 
       expect(response).to have_http_status(:success)
     end
     it "renders the #show view" do
 # #17
       get :show, topic_id: my_topic.id, id: my_spon_post.id 
       expect(response).to render_template :show
     end
 
     it "assigns my_spon_post to @post" do
       get :show, topic_id: my_topic.id, id: my_spon_post.id 
 # #18
       expect(assigns(:sponsoredpost)).to eq(my_spon_post)
     end
   end


   describe "GET edit" do
     it "returns http success" do
       get :edit, topic_id: my_topic.id, id: my_spon_post.id
       expect(response).to have_http_status(:success)
     end

     it "returns the #edit view" do
      get :edit, topic_id: my_topic.id, id: my_spon_post.id
      expect(response).to render_template :edit
     end

     it "assigns post to be updated to @post" do
      get :edit, topic_id: my_topic.id, id: my_spon_post.id

      post_instance = assigns(:sponsoredpost)

      expect(post_instance.id).to eq my_spon_post.id
      expect(post_instance.title).to eq my_spon_post.title
      expect(post_instance.body).to eq my_spon_post.body
     end
   end

   describe "PUT update" do
     it "updatesd post with expected attributes" do
       new_title = RandomData.random_sentence
       new_body = RandomData.random_paragraph

       put :update, topic_id: my_topic.id, id: my_spon_post.id, post: {title: new_title, body: new_body}

       updated_post = assigns(:sponsoredpost)
       expect(updated_post.id).to eq my_spon_post.id
       expect(updated_post.title).to eq new_title
       expect(updated_post.body).to eq new_body
     end

     it "redirects to teh updated post" do
       new_title = RandomData.random_sentence
       new_body = RandomData.random_paragraph

       put :update, topic_id: my_topic.id, id: my_spon_post.id, post: {title: new_title, body: new_body}
 # #30
       expect(response).to redirect_to [my_topic, my_spon_post]
     end
   end

  describe "DELETE destroy" do
     it "deletes the post" do
       delete :destroy, topic_id: my_topic.id, id: my_spon_post.id
       count = SponsoredPost.where({id: my_spon_post.id}).size
       expect(count).to eq 0
     end
 
     it "redirects to topic show" do
       delete :destroy, topic_id: my_topic.id, id: my_spon_post.id
        expect(response).to redirect_to my_topic

     end
   end

end

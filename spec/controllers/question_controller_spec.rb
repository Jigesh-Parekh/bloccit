require 'rails_helper'

RSpec.describe QuestionController, type: :controller do
#8
  let(:my_question) {Question.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, resolved: false)}

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  

    it "assigns [my_question] to @questions}" do
      get :index
#9
      expect(assigns(:questions)).to eq([my_question])
    end
  end

  describe "GET new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
#12
    it "renders the #new view" do
      get :new
      expect(response).to have_http_status(:success)
    end
#13
    it "instatinates @question" do
      get :new
      expect(assigns(:question)).not_to be_nil
    end
  end

  describe "POST create" do
      it "increases the number of Questions by 1" do
        expect{post :create, question: {title: RandomData.random_sentence, body: RandomData.random_paragraph, resolved: false}}.to change(Question,:count).by(1)
      end
 

    it "assigns the new question to @question" do
        post :create, question: {title: RandomData.random_sentence, body: RandomData.random_paragraph, resolved: false}
        expect(assigns(:question)).to eq Question.last
    end

    it "redirects to the new post" do
      post :create, question: {title: RandomData.random_sentence, body: RandomData.random_paragraph}
      expect(response).to redirect_to Question.last
    end
  end

   describe "GET show" do
     it "returns http success" do
 # #16
       get :show, {id: my_question.id}
       expect(response).to have_http_status(:success)
     end
     it "renders the #show view" do
 # #17
       get :show, {id: my_question.id}
       expect(response).to render_template :show
     end
 
     it "assigns my_question to @question" do
       get :show, {id: my_question.id}
 # #18
       expect(assigns(:question)).to eq(my_question)
     end
   end


   describe "GET edit" do
     it "returns http success" do
       get :edit, {id: my_question.id}
       expect(response).to have_http_status(:success)
     end

     it "returns the #edit view" do
      get :edit, {id: my_question.id}
      expect(response).to render_template :edit
     end

     it "assigns question to be updated to @question" do
      get :edit, {id: my_question.id}

      question_instance = assigns(:question)

      expect(question_instance.id).to eq my_question.id
      expect(question_instance.title).to eq my_question.title
      expect(question_instance.body).to eq my_question.body
     end
   end

   describe "PUT update" do
     it "updatesd question with expected attributes" do
       new_title = RandomData.random_sentence
       new_body = RandomData.random_paragraph
       new_resolved = false

       put :update, id: my_question.id, question: {title: new_title, body: new_body, resolved: new_resolved}

       updated_question = assigns(:question)
       expect(updated_question.id).to eq my_question.id
       expect(updated_question.title).to eq new_title
       expect(updated_question.body).to eq new_body
       expect(updated_question.resolved).to eq new_resolved
     end

     it "redirects to teh updated question" do
       new_title = RandomData.random_sentence
       new_body = RandomData.random_paragraph

       put :update, id: my_question.id, question: {title: new_title, body: new_body}
       expect(response).to redirect_to my_question
     end
   end

      describe "DELETE destroy" do
     it "deletes the question" do
       delete :destroy, {id: my_question.id}
       count = Question.where({id: my_question.id}).size
       expect(count).to eq 0
     end
 
     it "redirects to questions index" do
       delete :destroy, {id: my_question.id}
       expect(response).to redirect_to question_path
     end
   end

end
class Api::V1::TopicsController < Api::V1::BaseController

	before_action :authenticate_user, except: [:index, :show]
	before_action :authorize_user, except: [:index, :show]

	def index
		topics = Topic.all
		render json: topics, status: 200
	end

	def show
		topic = Topic.find(params[:id])
		render json: topic, status: 200
	end

	def update
		topic = Topic.find(params[:id])
		if topic.update_attributes(topic_params)
			render json: topic, status: 200
		else
			render json: {error: "Topiuc update failed", status: 400}, status: 400
		end
   end
 
   def create
   	topic = Topic.new(topic_params)
 
     if topic.valid?
       topic.save!
       render json: topic, status: 201
     else
       render json: {error: "Topic is invalid", status: 400}, status: 400
     end
   end
 
   def create_post
    topic = Topic.find(params[:id])
    post = topic.posts.build(post_params)
    post.user = @current_user

    if post.save
      render json: post.to_json, status: 200
    else
      render json: {error: "Post create failed", status: 400}, status: 400
    end
  end

  
   def destroy
   	topic = Topic.find(params[:id])
 
     if topic.destroy
       render json: {message: "Topic destroyed", status: 200}, status: 200
     else
       render json: {error: "Topic destroy failed", status: 400}, status: 400
     end
   end

   private
   def topic_params
     params.require(:topic).permit(:name, :description, :public)
   end
   def post_params
     params.require(:post).permit(:title, :body)
end
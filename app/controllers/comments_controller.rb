class CommentsController < ApplicationController
	#ensures guests are not allowed to comment
	before_action :require_sign_in
	before_action :authorize_user, only: [:destroy]

	def create
	  if params[:topic_id]  #comment controller needs a way to differentiate between topic and post
		@topic = Topic.find(params[:topic_id])
		comment = @topic.comments.new(comment_params)
		comment.user = current_user
		if comment.save
			flash[:notice] = "Comment Saved!"
			redirect_to @topic
		else
			flash[:alert] = "Comment failed to save"
			redirect_to @topic
		end
	  else
		@post = Post.find(params[:post_id])
		comment = @post.comments.new(comment_params)
		comment.user = current_user

		if comment.save
			flash[:notice] = "Comment Saved!"
			redirect_to [@post.topic, @post]
		else
			flash[:alert] = "Comment failed to save"
			redirect_to [@post.topic, @post]
		end
	  end
	end

	def destroy
	  comment = Comment.find(params[:id]) #try declaring outside so it can be called in both if else
	  if params[:post_id]
		@post = Post.find(params[:post_id])
		comment = @post.comments.find(params[:id])

		if comment.destroy
			flash[:notice] = "Comment was deleted sucessfully"
			redirect_to [@post.topic, @post]
		else 
			flash[:alert] = "Comment could not be deleted try again"
			redirect_to [@post.topic, @post]
		end
	  else
	    @topic = Topic.find(params[:topic_id])

	    if comment.destroy
	        flash[:notice] = "Comment was deleted."
	        redirect_to @topic
	    else
	        flash[:error] = "Comment couldn't be deleted. Try again."
	        redirect_to @topic
	    end	
	  end  	

	end



	private
	def comment_params
		params.require(:comment).permit(:body)
	end

	def authorize_user
		comment = Comment.find(params[:id])
		unless current_user == comment.user || current_user.admin?
			flash[:alert] = "You do not have permission to delete a comment"
			redirect_to [comment.post.topic, comment.post]
		end
	end
end

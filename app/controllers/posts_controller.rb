class PostsController < ApplicationController
  before_action :require_sign_in, except: :show

  def show
  	@post = Post.find(params[:id])
  end

  def new
    @topic = Topic.find(params[:topic_id])
  	@post = Post.new
  end

  def create
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.build(post_params)
    @post.user = current_user
    #allocates posts with users who created them
 #if post is sucessfully saved to databse flash notice posts a confirm message and redircts to post show view
  	if @post.save
       @post.labels = Label.update_labels(params[:post][:labels])
  		flash[:notice] = "Post was saved"
  		redirect_to [@topic, @post]
  	else
  		flash.now[:alert] = "There was an error saving the post please try again"
  		render :new
  	end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.assign_attributes(post_params)

    if @post.save
       @post.labels = Label.update_labels(params[:post][:labels])
      flash[:notice] = "Post was updated"
      redirect_to [@post.topic, @post]
    else
      flash.now[:alert] = "There was an error saving the post please try again"
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])

    if @post.destroy
      flash[:notice] = "\"#{@post.title}\" was deleted successfully"
      redirect_to @post.topic
    else
      flash.now[:alert] = "There was an error deleting the post"
      render :show
    end
  end


   private
   def post_params
     params.require(:post).permit(:title, :body)
   end
end

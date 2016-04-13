class PostsController < ApplicationController
  def index

  	@posts = Post.all
  end

  def show
  	@post = Post.find(params[:id])
  end

  def new
  	@post = Post.new
  end

  def create
  	@post = Post.new
  	@post.title = params[:post][:title]
  	@post.body = params[:post][:body]
 #if post is sucessfully saved to databse flash notice posts a confirm message and redircts to post show view
  	if @post.save
  		flash[:notice] = "Post was saved"
  		redirect_to @post
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
    @post.title = params[:post][:title]
    @post.body = params[:post][:body]

    if @post.save
      flash[:notice] = "Post was updated"
      redirect_to @post
    else
      flash.now[:alert] = "There was an error saving the post please try again"
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])

    if @post.destroy
      flash[:notice] = "\"#{@post.title}\" was deleted successfully"
      redirect_to posts_path
    else
      flash.now[:alert] = "There was an error deleting the post"
      render :show
    end
  end
end

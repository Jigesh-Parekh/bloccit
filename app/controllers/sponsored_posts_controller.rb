class SponsoredPostsController < ApplicationController
   def show
  	@sponsoredpost  = SponsoredPost.find(params[:id])
   end


  def new
    @topic = Topic.find(params[:topic_id])
  	@sponsoredpost = SponsoredPost.new
  end


  def create
   @sponsoredpost = SponsoredPost.new
   @sponsoredpost.title = params[:sponsored_post][:title]
   @sponsoredpost.body = params[:sponsored_post][:body]
    @topic = Topic.find(params[:topic_id])
    @sponsoredpost.topic = @topic
 #if post is sucessfully saved to databse flash notice posts a confirm message and redircts to post show view
  	if @sponsoredpost.save
  		flash[:notice] = "Post was saved"
  		redirect_to [@topic, @sponsoredpost]
  	else
  		flash.now[:alert] = "There was an error saving the post please try again"
  		render :new
  	end
  end

  def edit
    @sponsoredpost = SponsoredPost.find(params[:id])
  end

  def update
    @sponsoredpost = SponsoredPost.find(params[:id])
    @sponsoredpost.title = params[:sponsored_post][:title]
    @sponsoredpost.body = params[:sponsored_post][:body]

    if @sponsoredpost.save
      flash[:notice] = "Post was updated"
      redirect_to  [@sponsoredpost.topic, @sponsoredpost]
    else
      flash.now[:alert] = "There was an error saving the post please try again"
      render :edit
    end
  end

  def destroy
    @sponsoredpost = SponsoredPost.find(params[:id])

    if @sponsoredpost.destroy
      flash[:notice] = "\"# {@sponsoredpost.title}\" was deleted successfully"
      redirect_to @sponsoredpost.topic
    else
      flash.now[:alert] = "There was an error deleting the post"
      render :show
    end
  end
end

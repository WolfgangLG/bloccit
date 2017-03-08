class SponsoredPostsController < ApplicationController
  before_action :set_topic, only: [:new, :create, :update]
  before_action :set_sponsored_post, only: [:show, :edit, :update, :destroy]

  def show
  end

  def new
    @sponsored_post = SponsoredPost.new
  end

  def edit
  end

  def create
    @sponsored_post = SponsoredPost.new(sponsored_post_params)
    @sponsored_post.topic = @topic

    if @sponsored_post.save
      flash[:notice] = "Sponsored post was saved successfully"
      redirect_to [@topic, @sponsored_post]
    else
      flash.now[:alert] = "There was an error saving the sponsored post. Please try again."
      render :new
    end
  end

  def update
    if @sponsored_post.update(sponsored_post_params)
      redirect_to [@topic, @sponsored_post], notice: 'Sponsored post was successfully updated.'
    else
      flash.now[:alert] = "There was an error saving the sponsored post. Please try again."
      render :edit
    end
  end

  def destroy
    if @sponsored_post.destroy
      flash[:notice] = "Post number #{@sponsored_post.id} – \"#{@sponsored_post.title}\" was deleted successfully."
      redirect_to @sponsored_post.topic
    else
      flash.now[:alert] = "There was an error deleting the sponsored_post."
      render :show
    end
  end

  private
    def set_topic
      @topic = Topic.find(params[:topic_id])
    end

    def set_sponsored_post
      @sponsored_post = SponsoredPost.find(params[:id])
    end

    def sponsored_post_params
      params.require(:sponsored_post).permit(:title, :body, :price, :topic_id)
    end
end

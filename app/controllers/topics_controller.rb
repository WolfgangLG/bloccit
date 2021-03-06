class TopicsController < ApplicationController
  before_action :require_sign_in, except: [:index, :show]
  before_action :authorize_user, except: [:index, :show]
  before_action :set_topic, only: [:show, :edit, :update, :destroy]

  def index
    @topics = Topic.visible_to(current_user)
    # @topics.map { |topic| if topic.public == false; topic.name += " (Private Topic)" end }
  end

  def show
    unless @topic.public || current_user
      flash[:alert] = "You must be signed in to view private topics."
      redirect_to new_session_path
    end
  end

  def new
    @topic = Topic.new
  end

  def edit
  end

  def create
    @topic = Topic.new(topic_params)

    if @topic.save
      @topic.labels = Label.update_labels(params[:topic][:labels])
      redirect_to @topic, notice: 'Topic was successfully created.'
    else
      flash.now[:alert] = "Error creating topic. Please try again."
      render :new
    end
  end

  def update
    if @topic.update(topic_params)
      @topic.labels = Label.update_labels(params[:topic][:labels])
      redirect_to @topic, notice: 'Topic was successfully updated.'
    else
      flash.now[:alert] = "Error saving topic. Please try again."
      render :edit
    end
  end

  def destroy
    if @topic.destroy
      flash[:notice] = "\"#{@topic.name}\" was deleted successfully."
      redirect_to action: :index
    else
      flash.now[:alert] = "There was an error deleting the topic."
      render :show
    end
  end

  private
    def set_topic
      @topic = Topic.find(params[:id])
    end

    def topic_params
      params.require(:topic).permit(:name, :public, :description)
    end

    def authorize_user
     unless current_user.admin?
       flash[:alert] = "You must be an admin to do that."
       redirect_to topics_path
     end
   end
end

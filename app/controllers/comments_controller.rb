class CommentsController < ApplicationController
  before_filter :load_commentable
  before_action :require_sign_in
  before_action :authorize_user, only: [:destroy]
  before_action :create_redirecting


  def create
   comment = @commentable.comments.new(comment_params)
   comment.user = current_user

   if comment.save
      flash[:notice] = "Comment saved successfully."
      redirect_to @redirect
    else
      flash[:alert] = "Comment failed to save."
      redirect_to @redirect
    end
  end

  def destroy
    comment = @commentable.comments.find(params[:id])

    if comment.destroy
      flash[:notice] = "Comment was deleted successfully."
      redirect_to @redirect
    else
      flash[:alert] = "Comment couldn't be deleted. Try again."
      redirect_to @redirect
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def authorize_user
    comment = Comment.find(params[:id])
    unless current_user == comment.user || current_user.admin?
      flash[:alert] = "You do not have permission to delete a comment."
      redirect_to @redirect
    end
  end

  def load_commentable
    resource, id = request.path.split('/')[1, 2]
    @resource_type = resource
    @commentable = resource.singularize.classify.constantize.find(id)
  end

  def create_redirecting

    if @resource_type.include?("topic")
      @redirect = @commentable
    else
      @redirect = [@commentable.topic, @commentable]
    end
  end
end

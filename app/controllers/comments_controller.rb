class CommentsController < ApplicationController
  before_action :require_sign_in
  before_action :authorize_user, only: [:destroy]

  def create
    @post = Post.find(params[:post_id])
    comment = @post.comments.new(comment_params)
    comment.user = current_user

    if comment.save
       flash[:notice] = "Comment saved successfully."
       redirect_to [@post.topic, @post]
     else
       flash[:alert] = "Comment failed to save."
       redirect_to [@post.topic, @post]
     end
   end

   def destroy
     @post = Post.find(params[:post_id])
     comment = @post.comments.find(params[:id])

     if comment.destroy
       flash[:notice] = "Comment was deleted successfully."
       redirect_to [@post.topic, @post]
     else
       flash[:alert] = "Comment couldn't be deleted. Try again."
       redirect_to [@post.topic, @post]
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
       redirect_to [comment.post.topic, comment.post]
     end
   end

   describe "after_create" do
     before do
       @another_comment = Comment.new(body: 'Comment Body', post: post, user: user)
     end

     it "sends an email to users who have favorited the post" do
       favorite = user.favorites.create(post: post)
       expect(FavoriteMailer).to receive(:new_comment).with(user, post, @another_comment).and_return(double(deliver_now: true))

       @another_comment.save!
     end

     it "does not send emails to users who haven't favorited the post" do
       expect(FavoriteMailer).not_to receive(:new_comment)

       @another_comment.save!
     end
   end
end

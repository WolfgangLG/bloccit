module UsersHelper
  def user_has_posts_or_comments?
    @user.posts.any? || @user.comments.any?
  end
end

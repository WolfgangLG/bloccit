class FavoriteMailer < ApplicationMailer
  default from: "lgerdes@g2crowd.com"

  def new_comment(user, post, comment)

     headers["Message-ID"] = "<comments/#{comment.id}@your-app-name.example>"
     headers["In-Reply-To"] = "<post/#{post.id}@your-app-name.example>"
     headers["References"] = "<post/#{post.id}@your-app-name.example>"

     @user = user
     @post = post
     @comment = comment

     mail(to: user.email, subject: "New comment on #{post.title}")
   end

   def new_post(user, post)

     @user = user
     @post = post

     headers["References"] = "<post/#{post.id}@your-app-name.example>"

     mail(to: user.email, subject: "What next for your post: #{post.title}")
   end
end

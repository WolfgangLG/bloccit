class PostsController < ApplicationController
  def index
    @posts = Post.all
    @posts.map { |p| if ((p.id - 1) % 5 == 0); p.title = "SPAM"; end }
  end

  def show
  end

  def new
  end

  def edit
  end
end

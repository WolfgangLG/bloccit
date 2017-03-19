class AddCommentableToComments < ActiveRecord::Migration
  def change
    add_reference :comments, :commentable, polymorphic: :true, index: true
    remove_reference :posts, index: true, foreign_key: true
  end
end

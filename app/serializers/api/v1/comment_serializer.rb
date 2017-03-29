class Api::V1::CommentSerializer < ActiveModel::Serializer
  attributes :id, :body

  belongs_to :post
  belongs_to :user
end

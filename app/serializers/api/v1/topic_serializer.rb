class Api::V1::TopicSerializer < ActiveModel::Serializer
  attributes :id, :name, :public, :description, :created_at

  has_many :posts
end

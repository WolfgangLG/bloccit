class Api::V1::UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :password_digest, :created_at, :updated_at, :role, :auth_token
end

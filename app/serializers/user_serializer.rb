class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :sex, :description, :picture
end

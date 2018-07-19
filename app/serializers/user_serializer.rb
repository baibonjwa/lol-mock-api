class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :sex, :description, :picture
end

class Post < ActiveRecord::Base
	belongs_to :author, class_name: 'User'

	has_many :likes, as: :likeable
	has_many :comments
end

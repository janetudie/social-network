class Comment < ActiveRecord::Base
	belongs_to :author, class_name: 'User'
	belongs_to :post

	has_many :likes, as: :likeable
end

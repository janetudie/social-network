class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :posts,	foreign_key: :author_id, 
  									dependent: :destroy

  has_many :liked,	class_name: 'Like', 
  									foreign_key: :liker_id


  has_many :comments, foreign_key: :author_id

  has_one :profile, dependent: :destroy
  accepts_nested_attributes_for :profile

  has_many :friendships
  has_many :friends, -> { where(friendships: { approved: true }, user_id: id || friend_id: id) }, through: :friendships
  has_many :incoming_requests, -> { where(friendships: { approved: false }) }, through: :friendships, source: :friend
  has_many :outgoing_requests, -> { where(friendships: { approved: false }) }, through: :friendships, source: :user



  def feed
  	Post.where("author_id IN (?) OR author_id = ?", friend_ids, self.id)

    # SELECT * FROM posts
    # WHERE author_id IN (<friend ids>) OR author_id = <user id>

    # do you want to include likes and comments in this? then maybe use a 'feedable' polymorphism
  end

  def is_friend?(other_user)
    Friendship.where(user_id: self.id, friend_id: other_user.id, approved: true).exists?  # MUTUALS???
  end

end

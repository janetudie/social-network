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
  has_many :friends, -> { where(friendships: { approved: true }) }, through: :friendships
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: :friend_id
  has_many :inverse_friends, -> { where(friendships: { approved: true }) }, through: :inverse_friendships, source: :user



  # has_many :incoming_requests, -> { where(inverse_friendships: { approved: false }) }, through: :friendships, source: :friend
  # has_many :outgoing_requests, -> { where(friendships: { approved: false }) }, through: :friendships, source: :user



  def feed
  	Post.where("author_id IN (?) OR author_id = ?", friend_ids, self.id)

    # SELECT * FROM posts
    # WHERE author_id IN (<friend ids>) OR author_id = <user id>

    # do you want to include likes and comments in this? then maybe use a 'feedable' polymorphism
  end

  def likes?(likeable)
    Like.find_by(likeable_id: likeable.id)
  end

  def is_friend?(other_user)
    Friendship.where(user_id: self.id, friend_id: other_user.id, approved: true).exists? || Friendship.where(user_id: other_user.id, friend_id: self.id, approved: true).exists?
  end

 # def mutual_friends
 # inverse_friends.joins(:friendships).where("friendships.user_id = users.id and friendships.friend_id = :self_id", self_id: self.id).all
 # end

end

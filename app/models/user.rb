class User < ApplicationRecord
  acts_as_voter
  #has_many :likes
  has_many :photos
  has_many :albums
  has_many :follower_relationships, foreign_key: :following_id, class_name: 'Follow'
  has_many :followers, through: :follower_relationships, source: :follower
  has_many :following_relationships, foreign_key: :follower_id, class_name: 'Follow'
  has_many :followings, through: :following_relationships, source: :following
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  #Avatar:
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100#" }, :default_url => "./assets/heart.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  #First name (required): maximum 25 characters long. *
  validates :first_name, presence: true, length: { maximum: 25 }
  #Last name (required): maximum 25 characters long. *
  validates :last_name, presence: true, length: { maximum: 25 }
  #Email (required): maximum 255 characters long. Besides, it has to be unique and comply with the general email format. *
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX },  uniqueness: { case_sensitive: false }
  #Password (required): maximum 64 characters long.
  validates :password, length: {in: 6..64}, if: :password
  validates :password, presence: true, length: {in: 6..64}, on: :create
  def follow(user_id)
    following_relationships.create(following_id: user_id)
  end

  def unfollow(user_id)
    following_relationships.find_by(following_id: user_id).destroy
  end
end

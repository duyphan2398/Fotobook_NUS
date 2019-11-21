class Album < ApplicationRecord
  acts_as_votable
  belongs_to :user
  #has_many :likes, as: :imageable
  has_many :pics, as: :imageable, dependent: :destroy
  validates_presence_of :title
  default_scope -> { order(created_at: :desc) }

  #Title (required): maximum 140 characters long.
  validates :title, presence: true, length: { maximum: 140 }
  #Description (required): maximum 300 characters long.
  validates :description, presence: true, length: { maximum: 300 }
  #Sharing mode (required): public or private.
    # Từ form đã mặc định là true hoặc false
end

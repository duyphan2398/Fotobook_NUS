class Photo < ApplicationRecord
  acts_as_votable
  belongs_to :user

  has_attached_file :image
  #has_many :likes, as: :imageable
  #Title (required): maximum 140 characters long.
  validates :title, presence: true, length: { maximum: 140 }
  #Description (required): maximum 300 characters long.
  validates :description, presence: true, length: { maximum: 300 }
  #Sharing mode (required): public or private.
    # Từ form đã mặc định là true hoặc false
  #Attached image (required): maximum 01 image. Accepted formats are jpeq, png and gif. Maximum size is 5Mb.
  validates_attachment_content_type :image, content_type: ['image/jpg', 'image/jpeg', 'image/png', 'image/gif'], :file_size => {
      :maximum =>  5.megabytes.to_i
    }
  end

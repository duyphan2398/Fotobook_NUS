class Pic < ApplicationRecord
  belongs_to :imageable, polymorphic: true
  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" },
                                            default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image,content_type: ['image/jpg', 'image/jpeg', 'image/png', 'image/gif'], :file_size => {
    :maximum =>  5.megabytes.to_i
  }
end

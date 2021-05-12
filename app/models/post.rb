class Post < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one_attached :picture,dependent: :destroy
  validates :content, presence: true
  validates :picture, content_type: ["image/jpg", "image/png", "image/jpeg"]
end

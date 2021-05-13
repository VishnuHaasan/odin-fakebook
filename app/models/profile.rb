class Profile < ApplicationRecord
  belongs_to :user
  has_one_attached :dpicture,dependent: :destroy
  validates :dname, presence: true
  validates :bio, presence: true
  validates :age, presence: true
  validates :dpicture, content_type: ["image/jpeg", "image/jpg", "image/png"], presence: true
end

class Post < ApplicationRecord
  validates :user_id, presence: true
  validates :description, presence: true, length: { maximum: 240}
  validates :image, presence: true
  validates :name, presence: true
  validates :address, presence: true
  validates :noodle, presence: true
  validates :soup, presence: true
  belongs_to :user
  mount_uploader :image, ImageUploader
  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: 'user'
  geocoded_by :address
  after_validation :geocode, if: :address_changed?
  has_many :reviews, dependent: :destroy
end

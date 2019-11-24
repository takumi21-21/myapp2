class User < ApplicationRecord

  validates :name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, uniqueness: true, length: { maximum:255 },
                format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze }

  validates :password, presence: true, format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]{8,30}+\z/i }, length: { in: 8..30 }
  has_secure_password
  has_one_attached :image, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_posts, through: :favorites, source: 'post'
end

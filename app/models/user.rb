class User < ApplicationRecord

  validates :name, presence: true, unless: :uid?, length: { maximum: 30 }
  validates :email, presence: true, unless: :uid?, uniqueness: true, length: { maximum:255 },
                format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze }

  validates :password, format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]{8,30}+\z/i }, length: { in: 8..30 }, unless: :uid?
  has_secure_password validations: false
  has_one_attached :image, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_posts, through: :favorites, source: 'post'
  has_many :reviews, dependent: :destroy

  def self.find_or_create_form_auth(auth)
    provider = auth[:provider]
    uid = auth[:uid]
    name = auth[:info][:name]
    image = auth[:info][:image]

    self.find_or_create_by(provider: provider, uid: uid) do |user|
      user.name = name
      user.image_url = image
    end
  end


end

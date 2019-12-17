class Review < ApplicationRecord
  validates :content, presence: true
  validates :rate, numericality: { greater_than: 0 }
  belongs_to :user
  belongs_to :post
end

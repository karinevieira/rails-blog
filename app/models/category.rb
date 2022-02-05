class Category < ApplicationRecord
  has_many :articles
  
  validates :name, presence: true

  scope :sorted, -> { order(:name) }
end

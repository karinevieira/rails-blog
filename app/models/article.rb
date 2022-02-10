class Article < ApplicationRecord
  belongs_to :category

  validates :title, presence: true
  validates :body, presence: true

  scope :desc_order, -> { order(created_at: :desc) }
  scope :without_highlights, ->(ids) { where("id NOT IN (#{ids})") if ids.present? }
  scope :filter_by_category, ->(category) { where(category_id: category.id) if category.present? }
end

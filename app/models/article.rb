class Article < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true

  scope :desc_order, -> { order(created_at: :desc) }
  scope :without_highlights, ->(ids) { where("id NOT IN (#{ids})") if ids.present? }
end

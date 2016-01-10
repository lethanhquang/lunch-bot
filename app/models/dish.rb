class Dish < ActiveRecord::Base
  validates :name, presence: true

  has_many :order_items
  # scope :today, -> { where.not(item_number: nil) }
  scope :today, -> { where("created_at >= ?", Time.zone.now.beginning_of_day) }
end

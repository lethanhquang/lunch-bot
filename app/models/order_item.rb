class OrderItem < ActiveRecord::Base
  belongs_to :dish
  belongs_to :order

  validates :dish_id, presence: true
  validates :order_id, presence: true
  validates :username, presence: true

  def self.update_or_create(attributes)
    assign_or_new(attributes).save
  end

  def self.assign_or_new(attributes)
    obj = first || new
    obj.assign_attributes(attributes)
    obj
  end
end

class SaveOrderItemService
  LUNCH_CODE = "/order".freeze

  def self.call(info)
    return unless today_order

    messages = info["text"].split("-")
    number = messages.first ? messages.first.strip : 1
    description = messages.second ? messages.second.strip : ""

    Dish.where(item_number: number).each do |dish|
      OrderItem.where(
        order: today_order,
        username: info["user_name"],
      ).update_or_create(
        description: description,
        dish: dish
      )
    end

    #Dish.where(item_number: number).each do |dish|
      ##order_item = OrderItem.find_or_initialize_by(
        ##order: today_order,
        ##username: info["user_name"],
        ##description: description,
        ##dish: dish
      ##)
      ##order_item.save
    #end
  end

  def self.today_order
    order = Order.today.last
    if !order
      order = Order.new(description: 'Lunch').save
    end
    order
  end
end

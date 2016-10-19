class LunchController < ApplicationController
  skip_before_filter  :verify_authenticity_token, only: :order
  before_action :check_request, only: :order

  def menu
    content = format_content
    render status: 200, json: content
  end

  def order
    dish = SaveOrderItemService.call(params)
    content = format_content_order(dish)
    render status: 200, json: content
  end

  private

  def check_request
    return render json: {error: "No access permission"}, status: 401 if params["token"] != ENV["OUTGOING_TOKEN"]
  end

  def format_content
      content = ["<!here>*Yo! Menu for today*"]
      Dish.today.each do |dish|
        content << "#{dish.item_number}. #{dish.name}"
      end
        content << "\r\n"
        content << "To order your lunch try `/order <number>`"
      content.join("\n")
  end

  def format_content_order(dish)
    if dish.first
      content = ["*Got it!*"]
      content << "Your order: #{dish.first.name}"
      content.join("\n")
    else
      content = ["*Oh no!*"]
      content << "Try `/menu` to get correct dish number"
      content.join("\n")
    end
  end
end

class LunchController < ApplicationController
  before_action :check_request, only: :order

  def menu
    content = format_content
    render status: 200, json: content
  end

  def order
    SaveOrderItemService.call(params)
    render status: 200, json: "order"
  end

  private

  def check_request
    return render json: {error: "No access permission"}, status: 401 if params["token"] != ENV["OUTGOING_TOKEN"]
  end

  def format_content
      content = ["<!here> Menu for today"]
      Dish.today.each do |dish|
        content << "#{dish.item_number}. #{dish.name}"
      end
      content.join("\n")
  end
end

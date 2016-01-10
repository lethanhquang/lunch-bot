class LunchController < ApplicationController
  before_action :check_request, only: :order

  def menu
    response = {
      "response_type": "ephemeral",
      "text": "Here are the currently open tickets:",
      "attachments": [
        {
          "text": "#123456 http://domain.com/ticket/123456 \n
          #123457 http://domain.com/ticket/123457 \n
          #123458 http://domain.com/ticket/123458 \n
          #123459 http://domain.com/ticket/123459 \n
          #123460 http://domain.com/ticket/123460"
        }
      ]
    }
    # render status: 200, json: Dish.today
    render status: 200, json: response
  end

  def order
    SaveOrderItemService.call(params)
    render status: 200, json: "order"
  end

  private

  def check_request
    return render json: {error: "No access permission"}, status: 401 if params["token"] != ENV["OUTGOING_TOKEN"]
  end
end

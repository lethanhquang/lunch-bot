json.array!(@dishes) do |dish|
  json.extract! dish, :id, :name, :price
  json.url dish_url(dish, format: :json)
end

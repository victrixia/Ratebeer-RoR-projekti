json.array!(@active_breweries) do |brewery|
  json.extract! brewery, :id, :name, :year
  json.beercount do
    json.count brewery.beers.count
  end
end

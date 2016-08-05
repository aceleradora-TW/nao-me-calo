json.array!($establishments) do |establishment|
  json.extract! establishment, :id, :name, :address, :average_rating, :lat, :lng, :id_places
  json.url establishment_url(establishment, format: :json)
end

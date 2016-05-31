json.array!(@ratings) do |rating|
  json.extract! rating, :id, :woman, :lgbtqia, :black, :disability, :elder, :obese, :name, :cpf, :email, :phone, :rating_date
  json.url rating_url(rating, format: :json)
end

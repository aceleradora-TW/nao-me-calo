module RatingsHelper
  def clean_CPF_from_db
    starting_date = 6.months.ago
    ratings_to_erase_cpf = Rating.where("created_at <= :date OR updated_at <= :date", date: starting_date)
    ratings_to_erase_cpf.each do |rating|
      rating.update_attributes(cpf: "0")
    end
  end
end

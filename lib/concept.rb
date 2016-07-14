module Concept

  extend self

  def generate_concept(establishment)

    if establishment.has_more_than_2_ratings?
      general_average = []
      establishment.ratings.each do |rating|
        general_average.push(rating.average_rating) unless rating.average_rating.nil?
      end

      average_rating = general_average.sum/general_average.size #media geral do estabelecimento

      rating_concept = determine_concept(average_rating)
      return rating_concept
    else
      rating_concept = nil
    end
  end

  def determine_concept(rating)
    case rating
    when 1 ... 1.8
      rating_concept = "Péssimo"
    when 1.8 ... 2.6
      rating_concept = "Ruim"
    when 2.6 ... 3.4
      rating_concept = "Regular"
    when 3.4 ... 4.2
      rating_concept = "Bom"
    else
      rating_concept = "Ótimo"
    end
    rating_concept
  end

end

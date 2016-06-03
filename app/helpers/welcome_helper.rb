module WelcomeHelper
  def calculate_average_establishment(establishment)
    todasNotas = establishment.ratings.map do |rating|
      rating.average_rating
    end

    todasNotas.delete_if {|x| x == nil}

    return (todasNotas.sum/todasNotas.length).round(1)
  end
end

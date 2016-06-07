module ApplicationHelper
  def calculate_average_establishment(establishment)
    allRatings = establishment.ratings.map do |rating|
      rating.average_rating
    end

    allRatings.delete_if {|x| x == nil}

    return (allRatings.sum/allRatings.length).round(1)
  end
end

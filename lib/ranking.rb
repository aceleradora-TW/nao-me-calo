module Ranking

  extend self

  def generate_array_ranking(array)
    hash = {}
    array.each do |establishment|
      if establishment.has_more_than_2_ratings?
        hash[establishment] = establishment.calculate_average
      end
    end
    return hash.sort_by{ |_key, value| value }
  end
end

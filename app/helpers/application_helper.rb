module ApplicationHelper
  def calculate_average_establishment(establishment)
    all_ratings = establishment.ratings.map do |rating|
      rating.average_rating
    end

    all_ratings.delete_if {|x| x == nil}

    return (all_ratings.sum/all_ratings.length).round(1)
  end


  def flash_message
    messages = ""
    [:notice, :info, :warning, :error].each {|type|
      if flash[type]
        messages += "#{flash[type]}"
      end
    }

    messages
  end
end

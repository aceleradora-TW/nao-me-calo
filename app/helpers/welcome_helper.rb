module WelcomeHelper
  def set_average_style(average)
    case average
    when "Péssimo"
      return 'dangerous'
    when "Ruim"
      return 'bad'
    when "Regular"
      return 'regular'
    when "Bom"
      return 'good'
    else
      return 'excellent'
    end
  end


  def set_concept (places, array)
    array.take(10).each do |establishment|
      places << [establishment[0], establishment[1]]
    end
    places.each do |place|
      if place[1] < 2
        place[1] = "Péssimo"
      elsif place[1] < 3
        place[1] = "Ruim"
      elsif place[1] < 4
        place[1] = "Regular"
      elsif place[1] < 5
        place[1] = "Bom"
      else
        place[1] = "Ótimo"
      end
    end
  end
end

module WelcomeHelper
  def set_average_style(average)
    case average
    when "Péssimo"
      return 'concept-dangerous'
    when "Ruim"
      return 'concept-bad'
    when "Regular"
      return 'concept-regular'
    when "Bom"
      return 'concept-good'
    else
      return 'concept-excellent'
    end
  end


  def set_concept (places, array)
    array.take(10).each do |establishment|
      places << [establishment[0], establishment[1]]
    end
    places.each do |place|
      if place[1] < 1.8
        place[1] = "Péssimo"
      elsif place[1] < 2.6
        place[1] = "Ruim"
      elsif place[1] < 3.4
        place[1] = "Regular"
      elsif place[1] < 4.2
        place[1] = "Bom"
      else
        place[1] = "Ótimo"
      end
    end
  end
end

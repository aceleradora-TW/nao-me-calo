module WelcomeHelper

  def set_concept (array)
    places = []
    array.take(5).each do |establishment|
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

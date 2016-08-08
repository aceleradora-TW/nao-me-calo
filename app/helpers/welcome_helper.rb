module WelcomeHelper


  def generate_ranking
    array = Ranking.generate_array_ranking(@establishments)
    places = []
    array.each do |establishment|
      places << [establishment[0], establishment[1]]
    end
    places.each do |place|
      place[1] = Concept.determine_concept(place[1])
    end
  end

  # def generate_ranking_with_filter(city)
  #   array = Ranking.generate_array_ranking(Establishment.find_by_i)
  #   places = []
  #   array.each do |establishment|
  #     if establishment[0].city == city
  #       places << [establishment[0], establishment[1]]
  #     end
  #   end
  #   places.each do |place|
  #     place[1] = Concept.determine_concept(place[1])
  #   end
  # end
end

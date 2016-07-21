module WelcomeHelper

  def set_concept_for_welcome
    array = Ranking.generate_array_ranking(@establishments)
    places = []
    array.take(5).each do |establishment|
      places << [establishment[0], establishment[1]]
    end
    places.each do |place|
      place[1] = Concept.determine_concept(place[1])
    end
  end

  def set_concept_for_ranking
    array = Ranking.generate_array_ranking(@establishments)
    places = []
    array.each do |establishment|
      places << [establishment[0], establishment[1]]
    end
    places.each do |place|
      place[1] = Concept.determine_concept(place[1])
    end
  end
end

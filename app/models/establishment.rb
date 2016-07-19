class Establishment < ActiveRecord::Base
  include PgSearch
  validates :name, presence: true
  validates :address, presence: true
  validates :id_places, presence: true
  has_many :ratings
  accepts_nested_attributes_for :ratings

  pg_search_scope :search_by_id, :against => :id_places

  def has_more_than_2_ratings?
    total_ratings_moderated = 0
    self.ratings.each do |rating|
      if rating.moderated == true
        total_ratings_moderated += 1
      end
    end

    return total_ratings_moderated > 2
  end

  def calculate_average
    all_ratings = self.ratings.to_a.delete_if {|rating| rating.moderated == false}
    all_ratings = all_ratings.each.map do |rating|
      rating.average_rating
    end
    all_ratings.delete_if {|rating| rating == nil}
    return (all_ratings.sum/all_ratings.length).round(1)
  end

  def populate_rate_array(ratings)
    rate_array = []
    ratings.each do |rating|
      if rating.average_rating < 1.8
        rate_array.push([rating,"Péssimo"])
      elsif rating.average_rating < 2.6
        rate_array.push([rating,"Ruim"])
      elsif rating.average_rating < 3.4
        rate_array.push([rating,"Regular"])
      elsif rating.average_rating < 4.2
        rate_array.push([rating,"Bom"])
      else
        rate_array.push([rating,"Ótimo"])
      end
    end
    return rate_array
  end

end

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

end

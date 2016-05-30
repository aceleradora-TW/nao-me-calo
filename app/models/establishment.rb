class Establishment < ActiveRecord::Base
  include PgSearch
  has_many :ratings

  pg_search_scope :search_by_id, :against => :id_places
end

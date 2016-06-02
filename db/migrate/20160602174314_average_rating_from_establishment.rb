class AverageRatingFromEstablishment < ActiveRecord::Migration
  def change
    remove_column :establishments, :average_rating
  end
end

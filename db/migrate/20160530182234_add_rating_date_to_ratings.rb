class AddRatingDateToRatings < ActiveRecord::Migration
  def change
    add_column :ratings, :rating_date, :date
  end
end

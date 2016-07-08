class AddVisibleToRatings < ActiveRecord::Migration
  def change
    add_column :ratings, :visible, :boolean, default: false
  end
end

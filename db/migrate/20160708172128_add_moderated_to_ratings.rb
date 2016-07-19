class AddModeratedToRatings < ActiveRecord::Migration
  def change
    add_column :ratings, :moderated, :boolean, default: false
  end
end

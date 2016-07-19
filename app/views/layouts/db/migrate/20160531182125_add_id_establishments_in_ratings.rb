class AddIdEstablishmentsInRatings < ActiveRecord::Migration
  def change
    add_column :ratings, :establishment_id, :integer
  end
end

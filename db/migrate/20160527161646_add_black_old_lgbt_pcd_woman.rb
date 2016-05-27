class AddBlackOldLgbtPcdWoman < ActiveRecord::Migration
  def change
    add_column :ratings, :black, :float
    add_column :ratings, :old, :float
    add_column :ratings, :woman, :float
    add_column :ratings, :lgbt, :float
    add_column :ratings, :pcd, :float
  end
end

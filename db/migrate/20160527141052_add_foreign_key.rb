class AddForeignKey < ActiveRecord::Migration
  def change
    add_column :ratings, :lgbt, :integer
    add_column :ratings, :old, :float
    add_column :ratings, :woman, :float
    add_column :ratings, :black, :integer
    add_column :ratings, :pcd, :float

  end
end

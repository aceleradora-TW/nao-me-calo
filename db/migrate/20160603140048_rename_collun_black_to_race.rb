class RenameCollunBlackToRace < ActiveRecord::Migration
  def change
    rename_column :ratings, :black, :race
  end
end

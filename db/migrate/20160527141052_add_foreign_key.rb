class AddForeignKey < ActiveRecord::Migration
  def change
    add_column :ratings, :user_id, :integer
    add_column :ratings, :establishment_id, :integer
  end
end

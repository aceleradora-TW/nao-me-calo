class CreateEstablishments < ActiveRecord::Migration
  def change
    create_table :establishments do |t|
      t.string :name
      t.string :address
      t.float :average_rating
      t.string :lat
      t.string :lng
      t.string :id_places

      t.timestamps null: false
    end
  end
end

class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.float :woman
      t.float :lgbtqia
      t.float :black
      t.float :disability
      t.float :elder
      t.float :obese
      t.string :name
      t.string :cpf
      t.string :email
      t.string :phone
      t.date :rating_date

      t.timestamps null: false
    end
  end
end

class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.string :cpf_user
      t.float :grade

      t.timestamps null: false
    end
  end
end

class AddCityToEstablishments < ActiveRecord::Migration
  def change
    add_column :establishments, :city, :string
  end
end

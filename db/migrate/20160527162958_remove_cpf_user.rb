class RemoveCpfUser < ActiveRecord::Migration
  def change
    remove_column :ratings, :cpf_user
  end
end

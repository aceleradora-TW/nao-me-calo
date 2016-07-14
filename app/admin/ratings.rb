ActiveAdmin.register Rating do
  actions :all, except: [:new, :edit]

  action_item "Moderar", only: :show do
    link_to("Moderar", rating_moderated_path(rating.id), method: :put)
  end

  action_item "Toogle Visible", only: :show do
    link_to("Toggle Visible", rating_visible_path(rating.id), method: :put)
  end

  permit_params :woman, :lgbtqia, :race, :disability, :elder, :obese, :name, :cpf , :email, :phone, :description, :visible, :moderated

  index do
    selectable_column
    id_column
    column :moderated
    column :establishment_id
    column :description
    column :average_rating
    column :rating_date
    column :visible
    actions defaults: true do |rating|
      link_to("Toggle Visible", rating_visible_path(rating.id), method: :put)
    end
  end

  show do
    attributes_table :moderated, :visible, :name, :average_rating, :cpf, :description, :emai, :phone, :description
  end
end

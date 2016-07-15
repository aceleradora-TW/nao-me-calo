ActiveAdmin.register Rating do
  actions :all, except: [:new, :destroy, :edit]

  action_item "Visible", only: :show do
    link_to("Visible", rating_visible_path(rating.id), method: :put)
  end
  action_item "Moderated", only: :show do
    link_to("Moderated", rating_moderated_path(rating.id), method: :put)
  end


  # permit_params :woman, :lgbtqia, :race, :disability, :elder, :obese, :name, :cpf , :email, :phone, :description, :visible, :moderated

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
      link_to("Moderated", rating_moderated_path(rating.id), method: :put)
    end
    actions defaults: false do |rating|
     link_to("Visible", rating_visible_path(rating.id), method: :put)
   end
  end

  show do
    attributes_table :moderated, :visible, :name, :average_rating, :cpf, :email, :phone, :description
  end
end

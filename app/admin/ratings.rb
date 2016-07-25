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
    column "Description" do |rating|
      truncate(rating.description, :omision => "...", :length => 20)
    end
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
    attributes_table do
      row :moderated
      row :visible
      row :name
      row :average_rating
      row :cpf
      row :email
      row :phone
      row "Description" do |rating|
        word_wrap(rating.description, :line_width => 10)
      end
    end
  end
end

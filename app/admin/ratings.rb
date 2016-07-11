
ActiveAdmin.register Rating do
  actions :all, except: [:new, :destroy]

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #

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
    actions
  end

end

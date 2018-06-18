ActiveAdmin.register User do
# See permitted parameters documentation: 
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
  permit_params :name, :email, :password, :password_confirmation ,:gender, :image , :is_store
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end
index do
  selectable_column
  id_column
  column :name
  column :email
  column :created_at
  actions
end

form do |f|
  f.inputs do
    f.input :email
    f.input :name
    f.input :password
    f.input :password_confirmation
    f.input :gender
    f.input :image
    f.input :is_store
    
  end
  f.actions
end
end

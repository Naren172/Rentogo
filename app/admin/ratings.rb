ActiveAdmin.register Rating do
  actions :index, :show, :destroy
  index do 
    column :rating
    column :comment
    column :ratable_type  
    actions
  end

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :rating, :comment, :ratable_type, :ratable_id, :from_id
  #
  # or
  #
  permit_params do
    permitted = [:rating, :comment, :ratable_type, :ratable_id, :from_id]
    permitted << :other if params[:action] == 'create' && current_user.admin?
    permitted
  end

  filter :rating , :as => :select, :collection => Rating.pluck(:rating).uniq
  filter :comment
  filter :ratable_type, :as=> :select, :collection =>Rating.pluck(:ratable_type).uniq
  
end

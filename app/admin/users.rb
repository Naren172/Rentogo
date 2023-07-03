ActiveAdmin.register User do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :address
  #
  # or
  actions :index, :show, :destroy
  index do
    column :id
    column :account
    column :address
    actions
  end
  permit_params do
    permitted = [:address]
    permitted << :other if params[:action] == 'create' && current_user.admin?
    permitted
  end
  # filter :address , :as => :select, :collection => User.pluck(:address).uniq
  filter :account
end


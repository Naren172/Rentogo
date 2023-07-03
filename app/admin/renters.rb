ActiveAdmin.register Renter do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :aadhar
  #
  # or
  
  permit_params do
    permitted = [:aadhar]
    permitted << :other if params[:action] == 'create' && current_user.admin?
    permitted
  end
  actions :index, :show, :destroy
  index do 
    column :id
    column :account
    column :aadhar
    actions
  end

  filter :account
  filter :aadhar
  
end

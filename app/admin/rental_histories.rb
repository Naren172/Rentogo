ActiveAdmin.register RentalHistory do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :product_id, :renter_id
  #
  # or
  #
  permit_params do
    permitted = [:product_id, :renter_id]
    permitted << :other if params[:action] == 'create' && current_user.admin?
    permitted
  end
  actions :index, :show, :destroy
  index do
    column :product
    column 'Renter' do |model|
      link_to model.renter.account.name, admin_account_path(model.renter.account.id)
    end
    actions
  end
  
end

ActiveAdmin.register Delivery do
  
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :location, :payment_history_id, :rental_history_id
  #
  # or
  #
  permit_params do
    permitted = [:location, :payment_history_id, :rental_history_id]
    permitted << :other if params[:action] == 'create' && current_user.admin?
    permitted
  end

  filter :location
  
end

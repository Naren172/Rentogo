ActiveAdmin.register PaymentHistory do
  
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :rental_history_id, :cardnumber, :expiry, :cvc, :amount
  #
  # or
  #
  permit_params do
    permitted = [:rental_history_id, :cardnumber, :expiry, :cvc, :amount]
    permitted << :other if params[:action] == 'create' && current_user.admin?
    permitted
  end

  index do
    column :cardnumber
    column :cvc
    column :expiry
    column :amount
    actions
  end

  scope :all
  scope :payment_less_than_1000
  scope :payment_more_than_1000

  filter :amount , :as => :select, :collection => PaymentHistory.pluck(:amount).uniq
  filter :cardnumber
  filter :expiry
  
end

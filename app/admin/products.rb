ActiveAdmin.register Product do

  index do
    column :name
    column :status
    column :rent do |product|
     product.rent
    end
    actions
  end
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :name, :status, :user_id, :rent
  #
  # or
  
  permit_params do
    permitted = [:name, :status, :user_id, :rent]
    permitted << :other if params[:action] == 'create' && current_user.admin?
    permitted
  end
  

  scope :all
  scope :available_products
  scope :unavailable_products

  filter :name , :as => :select, :collection => Product.pluck(:name).uniq
  filter :rent
end

ActiveAdmin.register Account do
  actions :index, :show, :destroy
  index do
    column :id
    column :name
    column :email
    column :accountable_type
    actions
  end
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :name, :email, :accountable_type, :accountable_id, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at
  #
  # or


  filter :email
  filter :name
  filter :accountable_type

end

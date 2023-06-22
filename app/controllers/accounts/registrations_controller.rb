# frozen_string_literal: true

class Accounts::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    accountable = if params[:role][:role]=="Renter"
        Renter.new(renter_params)
    elsif params[:role][:role]=="Owner"
      User.new(owner_params )
    end
    accountable.save
    puts accountable.id

    build_resource(sign_up_params)
    resource.name = params[:account][:name]
    if params[:role][:role]=="Owner"
      resource.accountable_type="User"
    elsif
      resource.accountable_type=params[:role][:role].camelcase
    end
    resource.accountable_id = accountable.id
    resource.save


    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end
 
  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end
  
  protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  def after_sign_up_path_for(resource)
    if resource.user?
      owner_path
    elsif resource.renter?
      renter_path
    end
  end

  private
    def renter_params
      params.require(:renter_attributes).permit(:aadhar)
    end
    def owner_params
      params.require(:user_attributes).permit(:address)
    end
    def account_params
      params.require(:account).permit(:name)
    end
    def role_params
      params.require(:role).permit(:role)
    end

  # The path used after sign up for inactive acts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end

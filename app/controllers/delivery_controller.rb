class DeliveryController < ApplicationController
    before_action :authenticate_account!
    before_action :is_renter?
    def new
        @delivery=Delivery.new
        @payment=PaymentHistory.find(params[:id])
    end
    def create
        delivery=Delivery.new
        rental=RentalHistory.dind(params[:])
        delivery.
    end
    private
    def is_renter?
        unless account_signed_in? && current_account.renter?
            flash[:alert] = "Unauthorized action"
            if account_signed_in?
                redirect_to owner_path
            else
                redirect_to new_account_session_path
            end
        end
    end
end

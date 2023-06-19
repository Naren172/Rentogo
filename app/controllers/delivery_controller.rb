class DeliveryController < ApplicationController
    before_action :authenticate_account!
    before_action :is_renter?
    def new
        @delivery=Delivery.new
        @payment=PaymentHistory.find(params[:id])
    end
    
    def create
        delivery=Delivery.new
        pay=PaymentHistory.find(params[:payment_id])
        delivery.location=params[:location]
        delivery.rental_history_id=pay.rental_history_id
        pay.delivery=delivery
        delivery.save
        pay.save
        redirect_to rentershow_path
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

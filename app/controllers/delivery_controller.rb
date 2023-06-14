class DeliveryController < ApplicationController
    def new
        @delivery=Delivery.new
       
        @payment=PaymentHistory.find(params[:id])
    end

    def create
        delivery=Delivery.new
        rental=RentalHistory.dind(params[:])
        delivery.
    end
end

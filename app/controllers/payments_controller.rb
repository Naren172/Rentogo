class PaymentsController < ApplicationController
    def new
        @payment=PaymentHistory.new
        @product=Product.find(params[:product])
        @rental=RentalHistory.find(params[:rental])
    end


    def create
        @payment=PaymentHistory.new
        @payment.cardnumber=params[:cardnumber]
        @payment.expiry=params[:expiry]
        @payment.cvc=params[:cvc]
        @payment.amount=params[:amount]
        rental=RentalHistory.find(params[:rental_id])
        rental.payment_history=@payment
        product=Product.find(rental.product_id)
        product.applicants.delete_all   
        
        @payment.save
        rental.save
        redirect_to rentershow_path
    end


    def show
        renter=Renter.first
        @rentals=renter.rental_histories 
    end

    def showproduct
        @product=Product.find(params[:id])
    end

    def producthistory
        product=Product.find(params[:id])
        @rentals=product.rental_histories
        

    end
end

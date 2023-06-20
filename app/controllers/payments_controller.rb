class PaymentsController < ApplicationController
    before_action :authenticate_account!
    before_action :is_renter?, except: [:producthistory]
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
        product=Product.find(rental.product_id)
        product.applicants.delete_all   
        @payment.save
        redirect_to delivery_path(paymentid:@payment.id,rentalid:params[:rental_id])
    end

    def show
        account=current_account
        renter=Renter.find(account.accountable_id)
        @rentals=renter.rental_histories 
    end

    def showproduct
        @product=Product.find(params[:id])
    end

    def producthistory
        product=Product.find(params[:id])
        @rentals=product.rental_histories
    end

    private
    def is_renter?
        unless account_signed_in? && current_account.renter?
            if account_signed_in?
                redirect_to owner_path
            else
                redirect_to new_account_session_path
            end
        end
    end
end

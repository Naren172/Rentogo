class PaymentsController < ApplicationController
    before_action :authenticate_account!
    before_action :is_renter?, except: [:producthistory]
    before_action :is_owner?, only: [:producthistory]

    def new
        @payment=PaymentHistory.new
        @product=Product.find_by(id:params[:product])
        if @product
            @rental=RentalHistory.find_by(id:params[:rental])
            if @rental
            else
            redirect_to renterindex_path, error:"Not found"
            end
        else
            redirect_to renterindex_path, error:"Not found"
        end
    end

    def create
        payment=PaymentHistory.new
        payment.cardnumber=params[:cardnumber]
        payment.expiry=params[:expiry]
        payment.cvc=params[:cvc]
        payment.amount=params[:amount]
        rental=RentalHistory.find_by(id:params[:rental_id])
        if rental
            product=Product.find_by(id:rental.product_id)
            product.applicants.delete_all   
            payment.save
            redirect_to delivery_path(paymentid:payment.id,rentalid:params[:rental_id])
        else
            redirect_to renterindex_path, error:"Not found"
        end
    end

    def show
        account=current_account
        renter=Renter.find_by(id:account.accountable_id)
        @rentals=renter.rental_histories

    end

    def showproduct
        @product=Product.find_by(id:params[:id])
        if @product
        else
            redirect_to renterindex_path, error:"not found"
        end
    end

    def producthistory
        product=Product.find_by(id:params[:id])
        if product
            @rentals=product.rental_histories
        else
            redirect_to owner_path, error:"Not found"
        end
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

    def is_owner?
        unless account_signed_in? && current_account.user?
          if account_signed_in?
              redirect_to renterindex_path
          else
              redirect_to new_account_session_path
          end
        end
    end
end

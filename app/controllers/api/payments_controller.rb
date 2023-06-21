class Api::PaymentsController < Api::ApiController
    # before_action :authenticate_account!
    # before_action :is_renter?, except: [:producthistory]
    def new
        payment=PaymentHistory.new
        product=Product.find(params[:product])
        rental=RentalHistory.find(params[:rental])
    end

    def create
        payment=PaymentHistory.new
        payment.cardnumber=params[:cardnumber]
        payment.expiry=params[:expiry]
        payment.cvc=params[:cvc]
        payment.amount=params[:amount]
        rental=RentalHistory.find(params[:rental_id])
        product=Product.find(rental.product_id)
        product.applicants.delete_all   
        if payment.save
            render json: payment ,status: :ok
        else
            render json: { message: "Error while saving"}, status: :unprocessable_entity

        end
    
        # redirect_to delivery_path(paymentid:payment.id,rentalid:params[:rental_id])
    end

    def show
        # account=current_account
        renter=Renter.find_by(id:params[:renter_id])
        rentals=renter.rental_histories
        render json: rentals ,status: :ok

    end

    def showproduct
        product=Product.find(params[:id])
        render json: product, status: :ok
    end

    def producthistory
        product=Product.find(params[:id])
        rentals=product.rental_histories
        render json: rentals, status: :ok
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

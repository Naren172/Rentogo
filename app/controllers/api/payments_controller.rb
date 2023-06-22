class Api::PaymentsController < Api::ApiController
    before_action :is_renter?, except: [:producthistory]
    def new
        payment=PaymentHistory.new
        product=Product.find_by(id:params[:product])
        rental=RentalHistory.find_by(id:params[:rental])
    end

    def create
        payment=PaymentHistory.new
        payment.cardnumber=params[:cardnumber]
        payment.expiry=params[:expiry]
        payment.cvc=params[:cvc]
        payment.amount=params[:amount]
        rental=RentalHistory.find_by(id:params[:rental_id])
        product=Product.find_by(id:rental.product_id)
        product.applicants.delete_all   
        if payment.save
            render json: payment ,status: :ok
        else
            render json: { message: "Error while saving"}, status: :unprocessable_entity

        end
    end

    def show
        account=current_account
        renter=Renter.find_by(id:account.accountable_id)
        rentals=renter.rental_histories
        if rentals
            render json: rentals ,status: :ok
        else
            render json: { message: "Rental history not found"}, status: :not_found
        end
    end

    def showproduct
        product=Product.find_by(id:params[:id])
        if product
            render json: product, status: :ok
        else
            render json:{message:"Product not found!"}, status: :not_found
        end
    end

    def producthistory
        product=Product.find_by(id:params[:id])
        rentals=product.rental_histories
        if rentals
            render json: rentals, status: :ok
        else
            render json: {message:"Rental not found"}, status: :not_found
    end

    private
    def is_renter?
        unless current_account&& current_account.renter?
            render json: {message: "You are not authorized to view this page"} , status: :unauthorized
        end
    end
end

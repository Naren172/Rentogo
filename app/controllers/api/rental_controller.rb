class Api::RentalController < Api::ApiController
    # before_action :authenticate_account!
    # before_action :is_renter? , except: [:producthistory,:new]
    
    def new
        rental=RentalHistory.new
        product=Product.find(params[:productid])
        product.rental_histories<<rental
        renter=Renter.find(params[:renterid])
        renter.rental_histories<<rental
        product.update(status:"Unavailable")
        
        product.save
        renter.save
        if rental.save
            render json: rental , status: :ok
        else
            render json: {message:"Error while saving"}, status: :unprocessable_entity
        end
        # redirect_to products_path
    end

    def index
        renter=Renter.find_by(id:params[:renter_id])
        rentals=renter.rental_histories
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

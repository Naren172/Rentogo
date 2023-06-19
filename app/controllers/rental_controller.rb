class RentalController < ApplicationController
    before_action :authenticate_account!
    before_action :is_renter? , except: [:producthistory,:new]
    
    def new
        rental=RentalHistory.new
        product=Product.find(params[:productid])
        product.rental_histories<<rental
        renter=Renter.find(params[:renterid])
        renter.rental_histories<<rental
        product.update(status:"Unavailable")
        rental.save
        product.save
        renter.save
        redirect_to owner_path
    end

    def index
        renter=Renter.find(current_account.accountable_id)
        @rentals=renter.rental_histories
    end
    
    def producthistory
        @product=Product.find(params)
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

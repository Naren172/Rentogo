class RentalController < ApplicationController
    before_action :authenticate_account!
    before_action :is_renter? , except: [:new]
    
    def new
        rental=RentalHistory.new
        product=Product.find_by(id:params[:productid])
        if product
            product.rental_histories<<rental
            renter=Renter.find_by(id:params[:renterid])
            if renter
                renter.rental_histories<<rental
                product.update(status:"Unavailable")
                rental.save
                product.save
                renter.save
                redirect_to products_path
            else
                redirect_to owner_path
            end

        else
            redirect_to owner_path            
        end
    end

    def index
        renter=Renter.find_by(id:current_account.accountable_id)
        if renter
            @rentals=renter.rental_histories
        else
            redirect_to renterindex_path, error:"Not found"
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

end

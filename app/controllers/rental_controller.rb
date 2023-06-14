class RentalController < ApplicationController
   
    def new
        @rental=RentalHistory.new
        @product=Product.find(params[:id])
        @product.rental_histories<<@rental
        @renter=Renter.first
        @renter.rental_histories<<@rental
        @product.update(status:"Unavailable")
        @rental.save
        @product.save
        @renter.save
        redirect_to owner_path
    end


    def index
        @rentals=RentalHistory.all 
    end

    
    def producthistory
        @product=Product.find(params)
    end

end

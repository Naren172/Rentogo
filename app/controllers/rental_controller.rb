class RentalController < ApplicationController
   
    def new
        @rental=RentalHistory.new
        @product=Product.find(params[:id])
        @product.rental_histories<<@rental
        @rental.user_id=@product.user_id
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
        @products=[]
        @rentals.each do |rental|
            @products<<Product.find(rental.product_id)
        end


    end
  
end

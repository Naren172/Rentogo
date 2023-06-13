class RatingsController < ApplicationController
    def newproduct
        @product=Product.find(params[:id])
        
        puts @product
        @rating=Rating.new
    end
    def createproduct
        @user=Renter.first


        puts("...............")
        p params[:rating]
        p @user
        @rating=Rating.new(comment:params[:comment],rating:params[:rating],from_id:@user.id)
        p @rating
        @product=Product.find(params[:product_id])
        p @product
        @product.ratings<<@rating
        @rating.save
        @product.save
        redirect_to rentershow_path
        
    end


    
end

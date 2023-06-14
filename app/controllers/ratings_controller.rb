class RatingsController < ApplicationController
    def newproduct
        @product=Product.find(params[:id])
        puts @product
        @rating=Rating.new
    end


    def createproduct
        @user=Renter.first
        @rating=Rating.new(comment:params[:comment],rating:params[:rating],from_id:@user.id)
        @product=Product.find(params[:product_id])
        @product.ratings<<@rating
        @rating.save
        @product.save
        redirect_to rentershow_path
    end

    def newrenter
        @renter=Renter.find(params[:id])
        @rating=Rating.new
    end


    def createproduct
        @user=User.first
        @rating=Rating.new(comment:params[:comment],rating:params[:rating],from_id:@user.id)
        @renter=Renter.find(params[:renter_id])
        @renter.ratings<<@rating
        @rating.save
        @renter.save
        redirect_to products_path
    end


    
end

class MainController < ApplicationController
    def index
        @products= Product.all
        @renter=Renter.first
        a=@renter.id.to_i
        @applicants=Applicant.where(renter_id:@renter.id)

    end
    def show
        @product=Product.find(params[:id])
        @ratings=@product.ratings
        if(@ratings.length>0)

            @averagerating=0
            n=0
            @ratings.each do |rating|
               
                    @averagerating+=rating.rating
                    n+=1
               
            end
            @averagerating/=n
        end

    end
end

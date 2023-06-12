class MainController < ApplicationController
    def index
        @products= Product.all
    end
    def show
        @product=Product.find(params[:id])
        @ratings=@product.ratings
        if(@ratings!=[])

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

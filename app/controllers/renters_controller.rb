class RentersController < ApplicationController
    def view
        @renter=Renter.find(params[:id])
        @ratings=@renter.ratings
        @averagerating=0
        n=0
        @ratings.each do |rating|
            @averagerating+=rating.rating
            n+=1
        end
        @averagerating/=n

    end
end

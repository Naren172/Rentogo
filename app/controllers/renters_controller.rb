class RentersController < ApplicationController

    before_action :authenticate_account!
    before_action :is_owner?
    def view
        @renter=Renter.find_by(id:params[:id])
        if @renter
            @ratings=@renter.ratings
            if(@ratings.length>0)
                @averagerating=0
                n=0
                @ratings.each do |rating|
                    @averagerating+=rating.rating
                    n+=1 
                end
                @averagerating/=n
            end
        else
            redirect_to owner_path, error:"Not found"
        end
    end

    def rating

        @renter=Renter.find_by(id:params[:id])
        if @renter
            @renter
        else
            redirect_to owner_path, error:"Not found"
        end
       
    end

    private
    def is_owner?
        unless account_signed_in? && current_account.user?
            if account_signed_in?
                redirect_to renterindex_path
            else
                redirect_to new_account_session_path
            end
        end
    end
end

class MainController < ApplicationController
    before_action :authenticate_account!
    before_action :is_renter?
    def index
        @products=Product.all
        renter=Renter.find_by(id:current_account.accountable_id)
        @applicants=Applicant.where(renter_id:renter.id)

    end

    def show
        @product=Product.find_by(id:params[:id])
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

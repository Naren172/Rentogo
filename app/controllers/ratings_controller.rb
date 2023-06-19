class RatingsController < ApplicationController
    before_action :authenticate_account!
    before_action :is_owner?, except: [:newproduct , :createproduct]
    def newproduct
        @product=Product.find(params[:id])
        @rating=Rating.new
    end

    def createproduct
        account=current_account
        user=Renter.find(account.accountable_id)
        rating=Rating.new(comment:params[:comment],rating:params[:rating],from_id:user.id)
        product=Product.find(params[:product_id])
        product.ratings<<rating
        rating.save
        product.save
        redirect_to rentershow_path
    end

    def newrenter
        @renter=Renter.find(params[:id])
        @rating=Rating.new
    end

    def createuser

        user=User.find(current_account.accountable_id)
        rating=Rating.new(comment:params[:comment],rating:params[:rating],from_id:user.id)
        renter=Renter.find(params[:renter_id])
        renter.ratings<<rating
        rating.save
        renter.save
        redirect_to products_path
    end

    def is_owner?
        unless account_signed_in? && current_account.user?
            flash[:alert] = "Unauthorized action"
            if account_signed_in?
                redirect_to renterindex_path
            else
                redirect_to new_account_session_path
            end
        end
    end
end

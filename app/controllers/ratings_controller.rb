class RatingsController < ApplicationController
    before_action :authenticate_account!
    before_action :is_owner?, except: [:newproduct , :createproduct]
    def newproduct
        @product=Product.find_by(id:params[:id])
        @rating=Rating.new
    end

    def createproduct
        account=current_account
        user=Renter.find_by(id:account.accountable_id)
        @rating=Rating.new(comment:params[:comment],rating:params[:rating],from_id:user.id)
        product=Product.find_by(id:params[:product_id])
        product.ratings<<@rating
        product.save
        if @rating.save
            redirect_to rentershow_path
        else
            render :new, status: :unprocessable_entity
        end

    end

    def newrenter
        @renter=Renter.find_by(id:params[:id])
        @rating=Rating.new
    end

    def createuser

        user=User.find_by(id:current_account.accountable_id)
        @rating=Rating.new(comment:params[:comment],rating:params[:rating],from_id:user.id)
        renter=Renter.find_by(id:params[:renter_id])
        renter.ratings<<@rating
        renter.save
        if @rating.save
            redirect_to products_path
        else
            render :new, status: :unprocessable_entity
        end
    end

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

class RatingsController < ApplicationController
    before_action :authenticate_account!
    before_action :is_owner?, except: [:newproduct , :createproduct]
    before_action :is_renter?, except: [:newrenter , :createuser]

    def newproduct
        @product=Product.find_by(id:params[:id])
        if @product
            @rating=Rating.new
        else
            redirect_to renterindex_path, error:"Not found"
        end
    end

    def createproduct
        account=current_account
        user=Renter.find_by(id:account.accountable_id)
        @rating=Rating.new(comment:params[:comment],rating:params[:rating],from_id:user.id)
        product=Product.find_by(id:params[:product_id])
        if product
            product.ratings<<@rating
            product.save
            if @rating.save
                redirect_to rentershow_path
            else
                render :new, status: :unprocessable_entity
            end
        else
            redirect_to renterindex_path, error:"Not found"
        end

    end

    def newrenter
        @renter=Renter.find_by(id:params[:id])
        if @renter
            @rating=Rating.new
        else
            redirect_to owner_path, error:"Not found"
        end
    end

    def createuser
        user=User.find_by(id:current_account.accountable_id)
        @rating=Rating.new(comment:params[:comment],rating:params[:rating],from_id:user.id)
        renter=Renter.find_by(id:params[:renter_id])
        if renter
            renter.ratings<<@rating
            renter.save
            if @rating.save
                redirect_to products_path
            else
                render :new, status: :unprocessable_entity
            end
        else
            redirect_to owner_path, error:"Not found"
        end
    end

    def is_renter?
        unless account_signed_in? && current_account.renter?
            if account_signed_in?
                redirect_to owner_path
            else
                redirect_to new_account_session_path
            end
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

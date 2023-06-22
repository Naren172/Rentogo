class Api::RatingsController < Api::ApiController
    
    before_action :is_owner?, except: [:newproduct , :createproduct]
    def newproduct
        product=Product.find_by(id:params[:id])
        rating=Rating.new
    end

    def createproduct
        account=current_account
        user=Renter.find_by(id:account.accountable_id)
        rating=Rating.new(comment:params[:comment],rating:params[:rating],from_id:user.id)
        product=Product.find_by(id:params[:product_id])
        product.ratings<<rating
        product.save
        if rating.save
            render json: rating, status: :ok
        else
            render json: { message: "Error while saving"}, status: :unprocessable_entity
        end

    end

    def newrenter
        renter=Renter.find_by(id:params[:id])
        rating=Rating.new
    end

    def createuser
        user=User.find(current_account.accountable_id)
        rating=Rating.new(comment:params[:comment],rating:params[:rating],from_id:user.id)
        renter=Renter.find_by(id:params[:renter_id])
        renter.ratings<<rating
        renter.save
        if rating.save
            render json: rating, status: :ok
        else
            render json: { message: "Error while saving"}, status: :unprocessable_entity
        end
    end

    def is_owner?
        unless current_account && current_account.user?
            render json: {message: "You are not authorized to view this page"} , status: :unauthorized
        end
    end
end

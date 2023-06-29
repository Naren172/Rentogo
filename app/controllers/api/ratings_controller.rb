class Api::RatingsController < Api::ApiController
    
    before_action :is_owner?, except: [:createproduct,:productrating]
    before_action :is_renter?, except: [:createuser,:productrating]

    def createproduct
        account=current_account
        user=Renter.find_by(id:account.accountable_id)
        rating=Rating.new(comment:params[:comment],rating:params[:rating],from_id:user.id)
        product=Product.find_by(id:params[:product_id])
        if product
            product.ratings<<rating
            product.save
            if rating.save
                render json: rating, status: :ok
            else
                render json: { message: "Error while saving"}, status: :unprocessable_entity
            end
        else
            render json: { message: "No Product Found"}, status: :not_found
        end


    end

    def createuser
        user=User.find(current_account.accountable_id)
        rating=Rating.new(comment:params[:comment],rating:params[:rating],from_id:user.id)
        renter=Renter.find_by(id:params[:renter_id])
        if renter
            renter.ratings<<rating
            renter.save
            if rating.save
                render json: rating, status: :ok
            else
                render json: { message: "Error while saving"}, status: :unprocessable_entity
            end
        else
            render json: { message: "No Renter Found"}, status: :not_found
        end

    end

    #custom API 
    def productrating
        product=Product.find_by(id:params[:id])
        if product
            ratings=product.ratings
            if ratings
                render json: ratings, status: :ok
            else
                render json: {message:"no ratings for the product!"}, status: :not_found
            end
        else
            render json: { message: "No Product Found"}, status: :not_found
        end

    end

    def is_owner?
        unless current_account && current_account.user?
            render json: {message: "You are not authorized to view this page"} , status: :unauthorized
        end
    end

    def is_renter?
        unless current_account && current_account.renter?            
            render json: {message: "You are not authorized to view this page"} , status: :unauthorized
        end
    end
end

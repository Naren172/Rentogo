class Api::RentalController < Api::ApiController
    before_action :is_renter? , except: [:producthistory,:new]
    
    def new
        rental=RentalHistory.new
        product=Product.find_by(id:params[:productid])
        if product
            product.rental_histories<<rental
            renter=Renter.find_by(id:params[:renterid])
            if renter
                renter.rental_histories<<rental
                product.update(status:"Unavailable")
                product.save
                renter.save
                if rental.save
                    render json: rental , status: :ok
                else
                    render json: {message:"Error while saving"}, status: :unprocessable_entity
                end
            else
                render json: {message:"No renter found"}, status: :not_found
            end
        else
            render json: {message:"No product found"}, status: :not_found
        end
    end

    def index
        renter=Renter.find_by(id:current_account.accountable_id)
        rentals=renter.rental_histories
        if rentals
            render json: rentals, status: :ok
        else
            render json: {message:"No rentals found"}, status: :not_found
        end
    end
    
   

    private
    def is_renter?
        unless current_account && current_account.renter?
            render json: {message: "You are not authorized to view this page"} , status: :unauthorized
        end
    end

end

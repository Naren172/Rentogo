class Api::RentersController < Api::ApiController
?    # before_action :is_owner?
    def view
        renter=Renter.find_by(id:params[:id])
        ratings=renter.ratings
        if(ratings.length>0)
            averagerating=0
            n=0
            ratings.each do |rating|
                averagerating+=rating.rating
                n+=1 
            end
            averagerating/=n
        end
        render json: {renter:renter, ratings:ratings, averagerating:averagerating}, status: :ok
    end

    def rating
        renter=Renter.find_by(id:params[:id])
        if renter
            render json:renter, status: :ok
        else
            render json:{message:"No renter found"}, status: :not_found
        end
    end


    private
    def is_owner?
        unless current_account && current_account.user?
            render json: {message: "You are not authorized to view this page"} , status: :unauthorized
        end
    end
end

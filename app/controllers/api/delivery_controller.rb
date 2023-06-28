class Api::DeliveryController <  Api::ApiController
    before_action :is_renter?
    
    def create
        delivery=Delivery.new
        delivery.location=params[:location]
        delivery.rental_history_id=params[:rental_id]
        delivery.payment_history_id=params[:payment_id]
        if delivery.save
            render json: delivery , status: :created
        else
            render json: { message: "Error while saving"}, status: :unprocessable_entity
        end
    end

    private
    def is_renter?
        unless current_account && current_account.renter?
            render json: {message: "You are not authorized to view this page"} , status: :unauthorized
        end
    end
end

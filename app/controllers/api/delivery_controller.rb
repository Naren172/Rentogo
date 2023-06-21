class Api::DeliveryController <  Api::ApiController
    # before_action :authenticate_account!
    # before_action :is_renter?
    def new
        delivery=Delivery.new
        payment=PaymentHistory.find(params[:paymentid])
        rental=RentalHistory.find(params[:rentalid])
    end

    def create
        delivery=Delivery.new
        delivery.location=params[:location]
        delivery.rental_history_id=params[:rental_id]
        delivery.payment_history_id=params[:payment_id]
        if delivery.save
            render json: delivery , status: :ok
        else
            render json: { message: "Error while saving"}, status: :unprocessable_entity
        end
    end

    # private
    # def is_renter?
    #     unless account_signed_in? && current_account.renter?
    #         if account_signed_in?
    #             redirect_to owner_path
    #         else
    #             redirect_to new_account_session_path
    #         end
    #     end
    # end
end

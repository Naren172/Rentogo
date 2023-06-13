class PaymentsController < ApplicationController
    def new
        @payment=PaymentHistory.new
    end
end

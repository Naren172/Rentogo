class PaymentHistory < ApplicationRecord
    belongs_to :rental_history
    has_one :delivery
end

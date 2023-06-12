class RentalHistory < ApplicationRecord
    belongs_to :renter
    belongs_to :product
    has_one :payment_history
    has_one :delivery, through: :payment_history 
end

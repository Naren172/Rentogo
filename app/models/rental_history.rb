class RentalHistory < ApplicationRecord
    belongs_to :renter
    belongs_to :product
    has_one :delivery
    has_one :payment_history, through: :delivery
end

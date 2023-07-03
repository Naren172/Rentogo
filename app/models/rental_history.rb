class RentalHistory < ApplicationRecord
    belongs_to :renter
    belongs_to :product
    has_one :delivery, dependent: :destroy
    has_one :payment_history, through: :delivery, dependent: :destroy
end

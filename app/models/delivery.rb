class Delivery < ApplicationRecord
    belongs_to :payment_history
    belongs_to :rental_history
    validates :location, presence: true

end

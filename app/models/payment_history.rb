class PaymentHistory < ApplicationRecord
    has_one :delivery, dependent: :destroy
    scope :payment_less_than_1000, ->{PaymentHistory.where("amount <= ?",1000)}
    scope :payment_more_than_1000, ->{PaymentHistory.where("amount > ?",1000)}

end

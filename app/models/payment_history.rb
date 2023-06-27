class PaymentHistory < ApplicationRecord
    has_one :delivery, dependent: :destroy

    
    scope :payment_less_than_1000, ->{PaymentHistory.where("amount <= ?",1000)}
    scope :payment_more_than_1000, ->{PaymentHistory.where("amount > ?",1000)}

    validates :cardnumber, presence:true
    validates :cvc, presence:true
    validates :amount, presence:true, numericality: { only_integer: true ,greater_than_or_equal_to: 50}
    validates :expiry, presence:true

end

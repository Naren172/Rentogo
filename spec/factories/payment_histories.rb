FactoryBot.define do
  factory :payment_history do
    cardnumber {"1234567890"}
    cvc {"123"}
    amount {1234}
    expiry {"Wed, 21 Jun 2023"}
    
  end
end

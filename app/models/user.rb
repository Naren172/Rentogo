class User < ApplicationRecord
    has_one :account, as: :accountable, dependent: :destroy
    has_many :products, dependent: :destroy
end
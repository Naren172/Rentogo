class User < ApplicationRecord
    has_many :products, dependent: :destroy
    has_secure_password
    validates :name,length: {in:3..20}
end
class Account < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  belongs_to :accountable, polymorphic: true
  def user?
    if(accountable_type=="User")
      true
    elsif
      false
    end
  end

  def renter?
    if(accountable_type=="Renter")
      true
    elsif
      false
    end
  end
end

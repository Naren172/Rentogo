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

  
  validates :name, length: {minimum:5}
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP ,message:"Invalid Email" }
  validates :password, length: {minimum:6,message:"length must be a minimum of 6"}


  def self.authenticate(email,password)
    account = Account.find_for_authentication(email:email)
    account&.valid_password?(password)? account : nil
  end
  has_many :access_grants,
            class_name: 'Doorkeeper::AccessGrant',
            foreign_key: :resource_owner_id,
            dependent: :delete_all # or :destroy if you need callbacks

  has_many :access_tokens,
            class_name: 'Doorkeeper::AccessToken',
            foreign_key: :resource_owner_id,
            dependent: :delete_all 

end

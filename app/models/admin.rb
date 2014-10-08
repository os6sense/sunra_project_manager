class Admin < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :rememberable,
         :trackable,
         :validatable,
         :timeoutable

  before_save :ensure_authentication_token

  attr_accessible :email, :password, :password_confirmation, :remember_me

  def timeout_in
    30.minutes
  end

  def ensure_authentication_token
   if authentication_token.blank?
     self.authentication_token = generate_authentication_token
   end
  end

  private
  def generate_authentication_token
   loop do
     token = Devise.friendly_token
     break token unless Admin.where(authentication_token: token).first
   end
  end

end

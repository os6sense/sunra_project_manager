class BookingContactDetail < ActiveRecord::Base
  attr_accessible :email_or_phone
  validates :email_or_phone, :presence => true

  belongs_to :booking_contact
end

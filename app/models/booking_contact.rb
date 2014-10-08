class BookingContact < ActiveRecord::Base
  belongs_to :booking_company

  attr_accessible :contact_name
  validates  :contact_name, :presence => true

  has_many :booking_contact_details, :dependent => :destroy
  validates_associated :booking_contact_details
  accepts_nested_attributes_for :booking_contact_details, allow_destroy: true
end

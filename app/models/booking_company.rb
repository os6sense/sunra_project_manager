class BookingCompany < ActiveRecord::Base
  belongs_to :project

  attr_accessible :company_name, :booking_contacts_attributes
  validates :company_name, :presence => true, :uniqueness => true

  has_many :booking_contacts, :dependent => :destroy
  validates_associated :booking_contacts
  accepts_nested_attributes_for :booking_contacts, allow_destroy: true

  has_many :booking_contact_details, :through => :booking_contacts
end

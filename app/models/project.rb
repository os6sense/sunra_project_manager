require 'securerandom'

# ==== Description
class Project < ActiveRecord::Base
  self.primary_key = :uuid
  self.per_page = 10

  has_many :bookings, dependent: :delete_all, order: 'date DESC'
  has_one :client_login, dependent: :destroy

  validates_associated :bookings

  accepts_nested_attributes_for :bookings, allow_destroy: true
  accepts_nested_attributes_for :client_login, allow_destroy: true

  after_initialize :after_initialize

  attr_accessible :uuid,
                  :client_name,
                  :project_name,
                  :bookings_attributes,
                  :client_login_attributes

  validates :uuid,          presence: true
  validates :client_name,   presence: true
  validates :project_name,  presence: true

  validates_uniqueness_of :project_name, scope: :client_name

  default_scope includes(:bookings)
    .order('bookings.date DESC, bookings.start_time ASC')

  scope :today_pending, lambda { self.scoped :include => :bookings,
                        :conditions => ["bookings.date = ? AND bookings.end_time > ?", Date.today, Time.zone.now] }
  scope :present, lambda { self.scoped :include => :bookings,
                        :conditions => ["bookings.start_time < ? AND bookings.end_time > ?", Time.zone.now, Time.zone.now] }
  scope :today, lambda { self.scoped :include => :bookings,
                         :conditions => ["bookings.date = ?", Date.today] }
  scope :past, lambda { self.scoped :include => :bookings,
                        :conditions => [ "bookings.end_time < ?", Time.zone.now ] }
  scope :future, lambda { self.scoped :include => :bookings,
                        :conditions => [ "bookings.start_time > ? ",  Time.zone.now ] }

  scope :studio, lambda { |studio_id|  self.scoped :include => :bookings,
                :conditions => {'bookings.facility_studio' => studio_id } }
  scope :client_name, lambda { |client_name|  self.scoped :include => :bookings,
                :conditions => {'projects.client_name' => client_name } }
  scope :project_name, lambda { |project_name|  self.scoped :include => :bookings,
                :conditions => {'projects.project_name' => project_name } }

  def self.user_search(term)
    where("PROJECT_NAME LIKE ? OR CLIENT_NAME LIKE ? or DATE = ?", "%#{term}%", "%#{term}%", term)
  end

  # Description::
  # Use a uuid as the primary key
  def after_initialize
	  self.uuid ||= SecureRandom.hex(8)
  end
end

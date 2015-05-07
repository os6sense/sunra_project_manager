require_relative 'validators'

# ==== DESCRIPTION::
#
class Booking < ActiveRecord::Base

  belongs_to  :project

  before_save :before_save

  has_many    :recordings, :dependent => :destroy

  has_one     :studiolookup

  validates_associated :recordings

  accepts_nested_attributes_for :recordings, :allow_destroy => true

  attr_accessible :project_id,
                  :facility_studio,
                  :date,
                  :start_time,
                  :end_time,
                  :availability_notes,
                  :recordings_attributes,
                  :webcast

  validates :project_id,      presence: true
  validates :facility_studio, presence: true
  validates :start_time,      presence: true, bookingslot: true
  validates :end_time,        presence: true, endtimegreater: true
  validates :date,            presence: true # , notpast: true

  default_scope order 'date DESC, start_time DESC'

  scope :today, ->(_limit = 100) { where(date: Date.today) }
  scope :past, lambda{ where('date < ?', Date.today) }
  scope :future, ->(limit = 100) { where('date > ?', Date.today) }

  # ==== Description
  # Ensure the date in the start and end times match the booking date
  # Add 1 second to the booking when creating for the first time
  def before_save
    self.start_time += 1.second if self.created_at.nil?
  end

  def set_times(params)
    self.start_time = "#{self.date} #{params[:booking][:start_time]}"
    self.end_time = "#{self.date} #{params[:booking][:end_time]}"
  end

  # ==== Description
  # Move the end of the booking forward by +time+ minutes
  def nudge(time)
    return if (nudge_by_minutes = (time.to_i * 60)) <= 0

    # If the new end time overlaps with the beggining
    # of another booking move the start_time of that booking forward to our
    # new end time plus nudge_by_minutes.
    overlap = Booking.where(
      'start_time > ? and start_time < ? and facility_studio = ?',
      self.end_time, self.end_time + nudge_by_minutes, self.facility_studio
    )

    if overlap.size > 0
      overlap.each do |ol|
        ol.update_attribute(:start_time, ol.start_time + nudge_by_minutes)
      end
    end

    self.update_attribute(:end_time, self.end_time + nudge_by_minutes )
  end
end

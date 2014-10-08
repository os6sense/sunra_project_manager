class Recording < ActiveRecord::Base

  belongs_to :booking
  has_many :recording_formats, :dependent => :destroy
  validates_associated :recording_formats
  accepts_nested_attributes_for :recording_formats, :allow_destroy => true

  attr_accessible :booking_id,
	  			        :start_time,
				          :end_time,
				          :group_number,
	  			        :base_filename

  validates :booking_id, :presence => true
  validates :start_time, :presence => true
  validates :group_number, :presence => true
  validates :base_filename, :presence => true
end

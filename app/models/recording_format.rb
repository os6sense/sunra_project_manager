
class RecordingFormat < ActiveRecord::Base
  belongs_to :recording
  attr_accessible :recording_id,
                  :format,
                  :directory,
                  :filesize,
                  :start_time,
                  :end_time,
                  :sha1hash,
                  :upload,
                  :copy,
                  :encrypt,
                  :encrypted,
                  :fixed_moov_atom

  has_one :formatlookup

  validates :format, presence: true
  validates :directory, presence:  true

  # ==== Description
  # If params contains upload, copy, encrypt return the matching list of
  # formats
  def self.action_list(params)
    if params[:upload]
      return RecordingFormat.to_upload(params[:studio_id])
    elsif params[:copy]
      return RecordingFormat.to_copy(params[:studio_id])
    elsif params[:encrypt]
      return RecordingFormat.to_encrypt(params[:studio_id])
    end
    nil
  end

  # ==== Description
  # When a format is created its may come as an id OR as the string
  # representation e.g. 'mpg' or 'MPG' or '2'. On save is too late to fix
  # this
  def fix_format(fmt_string)
    if fmt_string.to_i > 0
      @format = fmt_string.to_i
    elsif (ext = FormatLookup.where(extension: fmt_string.upcase)[0])
      @format = ext[:id]
    else
      @format = 0
    end
  end

  def self.to_copy(studio_id = nil)
    _to_x_helper('copy', studio_id)
  end

  def self.to_upload(studio_id = nil)
    _to_x_helper('upload', studio_id)
  end

  def self.to_encrypt(studio_id = nil)
    _to_x_helper('encrypt', studio_id)
  end

  # DRYs up the to_xxxx methods
  def self._to_x_helper(sym, studio_id = nil)
    studio_id = SunraRestApi::Application::config.studio_id if studio_id.nil?

    joins(recording:  [:booking]).select(
      'bookings.project_id, recordings.booking_id, recording_formats.*'
    ).where(sym => true, 'bookings.facility_studio' => studio_id) || []
  end
end

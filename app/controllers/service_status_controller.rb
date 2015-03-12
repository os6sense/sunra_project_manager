class ServiceStatusController < ApplicationController
  respond_to :html

  def index
    @relay_status = ServiceStatus.ffmpeg_relay_status
    @recording_status = ServiceStatus.recording_service_status
    @uploader_status = ServiceStatus.uploader_service_status
    @failsafe_status = ServiceStatus.failsafe_service_status

    respond_with(@ffmpeg_relay_status,
                 @recording_status,
                 @uploader_status,
                 @failsafe_status)
  end

  def show
    respond_with(nil)
  end
end

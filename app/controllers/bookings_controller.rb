# BookingsController
require 'sunra_utils/config/uploader'
require "sunra_utils/rest_client"

class BookingsController < ApplicationController

  # _get_parents allow for multiple routes - /bookings would show all
  # but can still be nested.
  def _get_parents(b_id = nil)
    if params[:project_id]
      @project = Project.find(params[:project_id])
      bookings = b_id ? @project.bookings.find(b_id) : @project.bookings.all
    else
      bookings = b_id ? Booking.find(b_id) : Booking.all
    end
    return bookings
  end

  def index
    @bookings = _get_parents
    @bookings = @bookings.paginate(page: params[:page], per_page: 5)
    _simple_response(@bookings, include: [:recordings, :project])
  end

  # API endpoint intended for AJAX calls - marks the recording_formats
  # for upload and then starts the uploader service IF passed an immediate
  # value of true in the parameters.
  def mark
    @booking = _get_parents(params[:id])
    @booking.mark_for_upload(params[:rec_formats])

    # if there is an immediate param set to true, call the uploader
    # service manual upload url.
    start_uploader_service if !params[:immediate].blank? && params[:immediate] == 'true'

    respond_to do |format|
      format.html { render inline: 'ok' }
      format.json { head :no_content }
    end
  end

  # performs a call to the uploader service
  # Not really the place for this
  def start_uploader_service
    config = Sunra::Utils::Config::Uploader
    puts config.uploader_service_url
    begin
      rc = Sunra::Utils::RestClient.new(config.uploader_service_url)#), '', '')
      rc.get('manual_start')
    rescue
      return false
    end
    return true
  end

  def show
    @booking = _get_parents(params[:id])
    @recordings = @booking.recordings

    if params[:f].presence
      logger.info "booking action #{params[:f]}"
      case params[:f]
      when 'nudge'
        logger.info 'nudging'
        @booking.nudge(params[:time])
      end
    end

    _simple_response(@booking, include: :recordings)
  end

  def new
    @project = Project.find(params[:project_id])
    @booking = @project.bookings.new
    _simple_response(@booking)
  end

  def edit
    @booking = _get_parents(params[:id])
  end

  def create
    @project = Project.find(params[:project_id])

    @booking = @project.bookings.new(params[:booking])
    @booking.set_times(params) # BST/UTC problems should be addressed there

    respond_to do |format|
      if @booking.save
        format.html { redirect_to polymorphic_path([@project, @booking]) , notice: 'Booking was successfully created.' }
        format.json { render json: [@project, @booking], status: :created, location: [@project, @booking] }
      else
        format.html { render action: "new" }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @booking = _get_parents(params[:id])
    @booking.date = params[:booking][:date]

    @booking.set_times(params) # BST/UTC problems should be addressed there
    @booking.webcast = params[:booking][:webcast]

    respond_to do |format|
      if @booking.save
        format.html { redirect_to polymorphic_path([@project, @booking]), notice: 'Booking was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: [@project.errors, @booking.errors], status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @booking = _get_parents(params[:id])
    @booking.destroy

    respond_to do |format|
      format.html { redirect_to [@project] }
      format.json { head :no_content }
    end
  end
end

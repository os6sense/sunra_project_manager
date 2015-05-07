
class RecordingsController < ApplicationController

  def _get_parents r_id=nil
    if params[:booking_id]
      @project = Project.find(params[:project_id])
      @booking = @project.bookings.find(params[:booking_id])
      recordings = r_id ? @booking.recordings.find(r_id) : @booking.recordings.all
    else
      recordings = r_id ? Recording.find(r_id) : Recording.all
    end
    return recordings
  end

  def index
    @recordings = _get_parents()
    @recordings = @recordings.paginate(:page => params[:page], :per_page => PER_PAGE)
    _simple_response(@recordings, include: :recording_formats)
  end

  def show
    @recording = _get_parents(params[:id])

    # TODO: Dont need this, can use the included format in the view
    @recording_formats = @recording.recording_formats

    _simple_response(@recording, include: :recording_formats)
  end

  def new
    @booking = Booking.find(params[:booking_id])
    @project = @booking.project
    @recording = @booking.recordings.new
    _simple_response(@recording)
  end

  def edit
    @recording = _get_parents(params[:id])
  end

  def create
    @project = Project.find(params[:project_id])
    @booking = @project.bookings.find(params[:booking_id])
    @recording = @booking.recordings.new(params[:recording])

    @recording.parse_times(params)

    respond_to do |format|
      if @recording.save
        format.html { redirect_to polymorphic_path([@project, @booking, @recording]),
                      notice: 'Recording was successfully created.' }
        format.json { render json: [@project, @booking, @recording],
                      status: :created, location: [@project, @booking, @recording] }
      else
        format.html { render action: "new" }
        format.json { render json: @recording.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @recording = _get_parents(params[:id])

    @recording.update_attributes(params[:recording])
    @recording.parse_times(params)

    respond_to do |format|
      if @recording.save
        format.html { redirect_to polymorphic_path([@project, @booking, @recording]),
                      notice: 'Recording was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @recording.errors,
                      status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @recording = _get_parents(params[:id])
    @recording.destroy
    if @project
      _destroy_response([@project, @booking])
    else
      _destroy_response(:recordings)
    end
  end
end

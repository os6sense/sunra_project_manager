
class BookingsController < ApplicationController
  # allow for multiple routes - /bookings would show all
  # but can still be nested
  def _get_parents b_id=nil
    if params[:project_id]
      @project = Project.find(params[:project_id])
      bookings = b_id ? @project.bookings.find(b_id) : @project.bookings.all
    else
      bookings = b_id ? Booking.find(b_id) : Booking.all
    end
    return bookings
  end

  #def nudge
    #@booking = _get_parents(params[:id])
    #@booking.nudge(params[:time])
    #_simple_response(@booking, include: :recordings )
  #end

  def index
    @bookings = _get_parents()
    @bookings = @bookings.paginate(:page => params[:page], :per_page => PER_PAGE)
    _simple_response(@bookings, include: [:recordings, :project] )
  end

  def show
    @booking = _get_parents(params[:id])
    @recordings = @booking.recordings

    if params[:f].presence
      logger.info "booking action #{params[:f]}"
      case params[:f]
      when 'nudge'
        logger.info "nudging"
        @booking.nudge(params[:time])
      end
    end

    _simple_response(@booking, include: :recordings )
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

    respond_to do |format|
      if @booking.save
        format.html { redirect_to polymorphic_path([@project, @booking]) , notice: 'Booking was successfully created.' }
        format.json { render json: [@project, @booking], status: :created, location: @booking }
      else
        format.html { render action: "new" }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @booking = _get_parents(params[:id])

    respond_to do |format|
      if @booking.update_attributes(params[:booking])
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
    _destroy_response([@project, @booking])
  end
end

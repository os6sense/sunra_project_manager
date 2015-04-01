
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

  def index
    @bookings = _get_parents
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
    puts "CREATE"
    @project = Project.find(params[:project_id])
    @booking = @project.bookings.new(params[:booking])

    # Okay we definately have a bug here - commented out before save to but
    # I want to get up and running at this point
    if @booking.start_time == nil
      @booking.start_time = "#{@booking.date} #{params[:booking][:start_time]}"
      @booking.end_time = "#{@booking.date} #{params[:booking][:end_time]}"
    end

    puts @booking.inspect
    puts params[:booking]
    puts "NEW"

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

    respond_to do |format|
      format.html { redirect_to [@project] }
      format.json { head :no_content }
    end
  end
end

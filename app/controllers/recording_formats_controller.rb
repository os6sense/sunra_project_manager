
class RecordingFormatsController < ApplicationController
  def _get_parents r_fmt_id=nil
    if params[:recording_id]
      @recording = Recording.find(params[:recording_id])
      @booking = @recording.booking
      @project = @booking.project
      fmts = r_fmt_id ? @recording.recording_formats.find(r_fmt_id) : @recording.recording_formats.all
    else
      fmts = r_fmt_id ? RecordingFormat.find(r_fmt_id) : RecordingFormat.all
    end

    return fmts
  end

  def index
    if (@recording_formats = RecordingFormat.action_list(params)).nil?
      @recording_formats = _get_parents
    end

    @recording_formats =
      @recording_formats.paginate(page: params[:page], per_page: PER_PAGE)

    _simple_response(@recording_formats, include: :recording)
  end

  def show
    @recording_format = _get_parents(params[:id])
    _simple_response(@recording_format)
  end

  def new
    _get_parents
    @recording_format = @recording.recording_formats.new
    _simple_response(@recording_format)
  end

  def edit
    @recording_format = _get_parents(params[:id])
  end

  def create
    _get_parents

    @recording_format =
      @recording.recording_formats.new(params[:recording_format])
    @recording_format.fix_format(params[:recording_format][:format])

    respond_to do |format|
      if @recording_format.save
        format.html { redirect_to polymorphic_path(
                      [@project, @booking, @recording, @recording_format]),
                      :notice => 'Format was successfully created.' }
        format.json { render :json => [@project, @booking, @recording, @recording_format],
                      :status => :created, :location => [@project, @booking, @recording, @recording_format] }
      else
        format.html { render :action => "new" }
        format.json { render :json => @recording_format.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @recording_format = _get_parents(params[:id])

    respond_to do |format|
      if @recording_format.update_attributes(params[:recording_format])
        format.html { redirect_to polymorphic_path([@project, @booking, @recording, @recording_format]),
                      :notice => 'Format was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @recording_format.errors,
                      :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @recording_format = _get_parents(params[:id])
    @recording_format.destroy
    _destroy_response([@project, @booking, @recording])
  end
end

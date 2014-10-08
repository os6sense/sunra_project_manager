class StudioLookupsController < ApplicationController
  # GET /studio_lookups
  # GET /studio_lookups.json
  def index
    @studio_lookups = StudioLookup.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @studio_lookups }
    end
  end

  # GET /studio_lookups/1
  # GET /studio_lookups/1.json
  def show
    @studio_lookup = StudioLookup.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @studio_lookup }
    end
  end

  # GET /studio_lookups/new
  # GET /studio_lookups/new.json
  def new
    @studio_lookup = StudioLookup.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @studio_lookup }
    end
  end

  # GET /studio_lookups/1/edit
  def edit
    @studio_lookup = StudioLookup.find(params[:id])
  end

  # POST /studio_lookups
  # POST /studio_lookups.json
  def create
    @studio_lookup = StudioLookup.new(params[:studio_lookup])

    respond_to do |format|
      if @studio_lookup.save
        format.html { redirect_to @studio_lookup, :notice => 'Studio lookup was successfully created.' }
        format.json { render :json => @studio_lookup, :status => :created, :location => @studio_lookup }
      else
        format.html { render :action => "new" }
        format.json { render :json => @studio_lookup.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /studio_lookups/1
  # PUT /studio_lookups/1.json
  def update
    @studio_lookup = StudioLookup.find(params[:id])

    respond_to do |format|
      if @studio_lookup.update_attributes(params[:studio_lookup])
        format.html { redirect_to @studio_lookup, :notice => 'Studio lookup was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @studio_lookup.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /studio_lookups/1
  # DELETE /studio_lookups/1.json
  def destroy
    @studio_lookup = StudioLookup.find(params[:id])
    @studio_lookup.destroy

    respond_to do |format|
      format.html { redirect_to studio_lookups_url }
      format.json { head :no_content }
    end
  end
end

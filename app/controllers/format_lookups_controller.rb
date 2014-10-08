class FormatLookupsController < ApplicationController
  # GET /format_lookups
  # GET /format_lookups.json
  def index
    @format_lookups = FormatLookup.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @format_lookups }
    end
  end

  # GET /format_lookups/1
  # GET /format_lookups/1.json
  def show
    @format_lookup = FormatLookup.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @format_lookup }
    end
  end

  # GET /format_lookups/new
  # GET /format_lookups/new.json
  def new
    @format_lookup = FormatLookup.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @format_lookup }
    end
  end

  # GET /format_lookups/1/edit
  def edit
    @format_lookup = FormatLookup.find(params[:id])
  end

  # POST /format_lookups
  # POST /format_lookups.json
  def create
    @format_lookup = FormatLookup.new(params[:format_lookup])

    respond_to do |format|
      if @format_lookup.save
        format.html { redirect_to @format_lookup, :notice => 'Format lookup was successfully created.' }
        format.json { render :json => @format_lookup, :status => :created, :location => @format_lookup }
      else
        format.html { render :action => "new" }
        format.json { render :json => @format_lookup.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /format_lookups/1
  # PUT /format_lookups/1.json
  def update
    @format_lookup = FormatLookup.find(params[:id])

    respond_to do |format|
      if @format_lookup.update_attributes(params[:format_lookup])
        format.html { redirect_to @format_lookup, :notice => 'Format lookup was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @format_lookup.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /format_lookups/1
  # DELETE /format_lookups/1.json
  def destroy
    @format_lookup = FormatLookup.find(params[:id])
    @format_lookup.destroy

    respond_to do |format|
      format.html { redirect_to format_lookups_url }
      format.json { head :no_content }
    end
  end
end

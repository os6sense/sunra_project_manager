class BookingCompaniesController < ApplicationController
  # GET /booking_companies
  # GET /booking_companies.json
  def index
    @booking_companies = BookingCompany.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @booking_companies }
    end
  end

  # GET /booking_companies/1
  # GET /booking_companies/1.json
  def show
    @booking_company = BookingCompany.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @booking_company }
    end
  end

  # GET /booking_companies/new
  # GET /booking_companies/new.json
  def new
    @booking_company = BookingCompany.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @booking_company }
    end
  end

  # GET /booking_companies/1/edit
  def edit
    @booking_company = BookingCompany.find(params[:id])
  end

  # POST /booking_companies
  # POST /booking_companies.json
  def create
    @booking_company = BookingCompany.new(params[:booking_company])

    respond_to do |format|
      if @booking_company.save
        format.html { redirect_to @booking_company, notice: 'Booking company was successfully created.' }
        format.json { render json: @booking_company, status: :created, location: @booking_company }
      else
        format.html { render action: "new" }
        format.json { render json: @booking_company.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /booking_companies/1
  # PUT /booking_companies/1.json
  def update
    @booking_company = BookingCompany.find(params[:id])

    respond_to do |format|
      if @booking_company.update_attributes(params[:booking_company])
        format.html { redirect_to @booking_company, notice: 'Booking company was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @booking_company.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /booking_companies/1
  # DELETE /booking_companies/1.json
  def destroy
    @booking_company = BookingCompany.find(params[:id])
    @booking_company.destroy

    respond_to do |format|
      format.html { redirect_to booking_companies_url }
      format.json { head :no_content }
    end
  end
end

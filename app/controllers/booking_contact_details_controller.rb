class BookingContactDetailsController < ApplicationController
  # GET /booking_contact_details
  # GET /booking_contact_details.json
  def index
    @booking_contact_details = BookingContactDetail.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @booking_contact_details }
    end
  end

  # GET /booking_contact_details/1
  # GET /booking_contact_details/1.json
  def show
    @booking_contact_detail = BookingContactDetail.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @booking_contact_detail }
    end
  end

  # GET /booking_contact_details/new
  # GET /booking_contact_details/new.json
  def new
    @booking_contact_detail = BookingContactDetail.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @booking_contact_detail }
    end
  end

  # GET /booking_contact_details/1/edit
  def edit
    @booking_contact_detail = BookingContactDetail.find(params[:id])
  end

  # POST /booking_contact_details
  # POST /booking_contact_details.json
  def create
    @booking_contact_detail = BookingContactDetail.new(params[:booking_contact_detail])

    respond_to do |format|
      if @booking_contact_detail.save
        format.html { redirect_to @booking_contact_detail, notice: 'Booking contact detail was successfully created.' }
        format.json { render json: @booking_contact_detail, status: :created, location: @booking_contact_detail }
      else
        format.html { render action: "new" }
        format.json { render json: @booking_contact_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /booking_contact_details/1
  # PUT /booking_contact_details/1.json
  def update
    @booking_contact_detail = BookingContactDetail.find(params[:id])

    respond_to do |format|
      if @booking_contact_detail.update_attributes(params[:booking_contact_detail])
        format.html { redirect_to @booking_contact_detail, notice: 'Booking contact detail was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @booking_contact_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /booking_contact_details/1
  # DELETE /booking_contact_details/1.json
  def destroy
    @booking_contact_detail = BookingContactDetail.find(params[:id])
    @booking_contact_detail.destroy

    respond_to do |format|
      format.html { redirect_to booking_contact_details_url }
      format.json { head :no_content }
    end
  end
end

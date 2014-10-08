class BookingContactsController < ApplicationController
  # GET /booking_contacts
  # GET /booking_contacts.json
  def index
    @booking_contacts = BookingContact.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @booking_contacts }
    end
  end

  # GET /booking_contacts/1
  # GET /booking_contacts/1.json
  def show
    @booking_contact = BookingContact.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @booking_contact }
    end
  end

  # GET /booking_contacts/new
  # GET /booking_contacts/new.json
  def new
    @booking_contact = BookingContact.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @booking_contact }
    end
  end

  # GET /booking_contacts/1/edit
  def edit
    @booking_contact = BookingContact.find(params[:id])
  end

  # POST /booking_contacts
  # POST /booking_contacts.json
  def create
    @booking_contact = BookingContact.new(params[:booking_contact])

    respond_to do |format|
      if @booking_contact.save
        format.html { redirect_to @booking_contact, notice: 'Booking contact was successfully created.' }
        format.json { render json: @booking_contact, status: :created, location: @booking_contact }
      else
        format.html { render action: "new" }
        format.json { render json: @booking_contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /booking_contacts/1
  # PUT /booking_contacts/1.json
  def update
    @booking_contact = BookingContact.find(params[:id])

    respond_to do |format|
      if @booking_contact.update_attributes(params[:booking_contact])
        format.html { redirect_to @booking_contact, notice: 'Booking contact was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @booking_contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /booking_contacts/1
  # DELETE /booking_contacts/1.json
  def destroy
    @booking_contact = BookingContact.find(params[:id])
    @booking_contact.destroy

    respond_to do |format|
      format.html { redirect_to booking_contacts_url }
      format.json { head :no_content }
    end
  end
end

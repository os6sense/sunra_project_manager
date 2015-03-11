class ServiceStatusesController < ApplicationController
  before_filter :set_service_status, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @service_statuses = ServiceStatus.all
    respond_with(@service_statuses)
  end

  def show
    respond_with(@service_status)
  end

  def new
    @service_status = ServiceStatus.new
    respond_with(@service_status)
  end

  def edit
  end

  def create
    @service_status = ServiceStatus.new(params[:service_status])
    @service_status.save
    respond_with(@service_status)
  end

  def update
    @service_status.update_attributes(params[:service_status])
    respond_with(@service_status)
  end

  def destroy
    @service_status.destroy
    respond_with(@service_status)
  end

  private
    def set_service_status
      @service_status = ServiceStatus.find(params[:id])
    end
end

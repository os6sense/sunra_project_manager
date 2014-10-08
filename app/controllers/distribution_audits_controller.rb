class DistributionAuditsController < ApplicationController
  # GET /distribution_audits
  # GET /distribution_audits.json
  def index
    @distribution_audits = DistributionAudit.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @distribution_audits }
    end
  end

  # GET /distribution_audits/1
  # GET /distribution_audits/1.json
  def show
    @distribution_audit = DistributionAudit.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @distribution_audit }
    end
  end

  # GET /distribution_audits/new
  # GET /distribution_audits/new.json
  def new
    @distribution_audit = DistributionAudit.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @distribution_audit }
    end
  end

  # GET /distribution_audits/1/edit
  def edit
    @distribution_audit = DistributionAudit.find(params[:id])
  end

  # POST /distribution_audits
  # POST /distribution_audits.json
  def create
    @distribution_audit = DistributionAudit.new(params[:distribution_audit])

    respond_to do |format|
      if @distribution_audit.save
        format.html { redirect_to @distribution_audit, :notice => 'Distribution audit was successfully created.' }
        format.json { render :json => @distribution_audit, :status => :created, :location => @distribution_audit }
      else
        format.html { render :action => "new" }
        format.json { render :json => @distribution_audit.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /distribution_audits/1
  # PUT /distribution_audits/1.json
  def update
    @distribution_audit = DistributionAudit.find(params[:id])

    respond_to do |format|
      if @distribution_audit.update_attributes(params[:distribution_audit])
        format.html { redirect_to @distribution_audit, :notice => 'Distribution audit was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @distribution_audit.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /distribution_audits/1
  # DELETE /distribution_audits/1.json
  def destroy
    @distribution_audit = DistributionAudit.find(params[:id])
    @distribution_audit.destroy

    respond_to do |format|
      format.html { redirect_to distribution_audits_url }
      format.json { head :no_content }
    end
  end
end

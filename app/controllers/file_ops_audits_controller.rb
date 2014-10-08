class FileOpsAuditsController < ApplicationController
  # GET /file_ops_audits
  # GET /file_ops_audits.json
  def index
    @file_ops_audits = FileOpsAudit.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @file_ops_audits }
    end
  end

  # GET /file_ops_audits/1
  # GET /file_ops_audits/1.json
  def show
    @file_ops_audit = FileOpsAudit.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @file_ops_audit }
    end
  end

  # GET /file_ops_audits/new
  # GET /file_ops_audits/new.json
  def new
    @file_ops_audit = FileOpsAudit.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @file_ops_audit }
    end
  end

  # GET /file_ops_audits/1/edit
  def edit
    @file_ops_audit = FileOpsAudit.find(params[:id])
  end

  # POST /file_ops_audits
  # POST /file_ops_audits.json
  def create
    @file_ops_audit = FileOpsAudit.new(params[:file_ops_audit])

    respond_to do |format|
      if @file_ops_audit.save
        format.html { redirect_to @file_ops_audit, :notice => 'File ops audit was successfully created.' }
        format.json { render :json => @file_ops_audit, :status => :created, :location => @file_ops_audit }
      else
        format.html { render :action => "new" }
        format.json { render :json => @file_ops_audit.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /file_ops_audits/1
  # PUT /file_ops_audits/1.json
  def update
    @file_ops_audit = FileOpsAudit.find(params[:id])

    respond_to do |format|
      if @file_ops_audit.update_attributes(params[:file_ops_audit])
        format.html { redirect_to @file_ops_audit, :notice => 'File ops audit was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @file_ops_audit.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /file_ops_audits/1
  # DELETE /file_ops_audits/1.json
  def destroy
    @file_ops_audit = FileOpsAudit.find(params[:id])
    @file_ops_audit.destroy

    respond_to do |format|
      format.html { redirect_to file_ops_audits_url }
      format.json { head :no_content }
    end
  end
end

class ClientLoginsController < ApplicationController

  def _get_parents cl_id=nil
    if params[:project_id]
      @project = Project.find(params[:project_id])
      client_logins = cl_id ? @project.client_logins.find(cl_id) : @project.client_logins.all
    else
      client_logins = cl_id ? ClientLogin.find(cl_id) : ClientLogin.all
    end
    return client_logins
  end

  def index
    @client_logins = _get_parents()
    _simple_response(@client_logins)
  end

  def show
    @client_login = _get_parents(params[:id])
    _simple_response(@client_login)
  end

  def new
    @project = Project.find(params[:project_id])
    @client_login = @project.client_logins.new
    _simple_response(@client_login)
  end

  def edit
    @client_login = _get_parents(params[:id])
  end

  def create
    @project = Project.find(params[:project_id])
    @client_login = @project.client_logins.new(params[:client_login])

    respond_to do |format|
      if @client_login.save
        format.html { redirect_to polymorphic_path([@project, @client_login]),
                      notice: 'Client Login was successfully created.' }
        format.json { render json: [@project, @client_login], 
                      status: :created, location: [@project, @client_login] }
      else
        format.html { render action: "new" }
        format.json { render json: @client_login.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @client_login = _get_parents(params[:id])

    respond_to do |format|
      if @client_login.update_attributes(params[:client_login])
        format.html { redirect_to polymorphic_path([@project,  @client_login]),
                      notice: 'Client Login was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @client_login.errors,
                      status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @client_login = _get_parents(params[:id])
    @client_login.destroy
    _destroy_response([@project ])
  end
end

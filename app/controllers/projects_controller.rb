
class ProjectsController < ApplicationController

  def index
    @projects = Project

    # Allows for the display of either only bookings today, from the past,
    # or future.
    unless (ppf=params[:ppf]).blank?
      if %w( today_pending today past present future ).include? ppf
        @projects = @projects.send(ppf.to_sym)
      end
    end

    # I have no idea where I used this - TODO!
    %w(studio client_name project_name).each do |k|
      unless (val = params[k.to_sym]).blank?
        @projects = @projects.send(k.to_sym, val)
      end
    end

    @projects = @projects.paginate(page: params[:page], per_page: 11)
    _simple_response(@projects, include: :bookings)
  end


  def search
    # Allow for a custom search.
    unless params[:search].blank?
      @projects = Project.user_search(params[:search])
    end

    @projects = @projects.paginate(page: params[:page], per_page: 11)
    render :index
  end


  def show
    @project = Project.find(params[:id])
    @bookings = @project.bookings.paginate(page: params[:page], per_page: 7)
    _simple_response @project
  end

  def new
    @project = Project.new

    # Use the quickproject view
    if (params[:qp])
      render :quickproject
    else
      _simple_response @project
    end
  end

  def edit
    @project = Project.find(params[:id])
  end

  def create
    @project = Project.new(params[:project])

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render json: @project, status: :created, location: @project }
      else
        format.html { render action: "new" }
        format.json { render json: { errors: @project.errors }, status: :unprocessable_entity }
      end
    end
  end

  def update
    @project = Project.find(params[:id])

    respond_to do |format|
      if @project.update_attributes(params[:project])
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy

    respond_to do |format|
      format.html { redirect_to projects_url }
      format.json { head :no_content }
    end
  end
end

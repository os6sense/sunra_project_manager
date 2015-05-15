class AdminsController < ApplicationController
  def index
    @admins = Admin.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def show
    @admin = Admin.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  def new
    @admin = Admin.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  def edit
    @admin = Admin.find(params[:id])
  end

  def create
    @admin = Admin.new(params[:admin])

    respond_to do |format|
      if @admin.save
        format.html { redirect_to @admin, :notice => 'Admin successfully created.' }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @admin = Admin.find(params[:id])

    respond_to do |format|
      if @admin.update_attributes(params[:admin])
        format.html { redirect_to @admin, :notice => 'Admin successfully updated.' }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @admin = Admin.find(params[:id])
    @admin.destroy

    respond_to do |format|
      format.html { redirect_to admins_url }
    end
  end
end

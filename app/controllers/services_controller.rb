class ServicesController < ApplicationController

  before_filter :authenticate_admin!

  def index
    @services = Service.all
  end

  def new
    @service = Service.new
  end

  def create
    @service = Service.new(params[:service])
    if @service.save
      flash[:notice] = "The service was created successfully."
      redirect_to :action => :index
    else
      render :action => :new
    end
  end

  def edit
    @service = Service.find(params[:id])
  end

  def update
    @service = Service.find(params[:id])
    if @service.update_attributes(params[:service])
      flash[:notice] = "The service was updated successfully."
      redirect_to :action => :index
    else
      render :action => :edit
    end
  end
end

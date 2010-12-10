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
end

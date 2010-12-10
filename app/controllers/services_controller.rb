class ServicesController < ApplicationController

  before_filter :authenticate_admin!

  def index
    @services = Service.all
  end

  def new
    @service = Service.new
  end

end

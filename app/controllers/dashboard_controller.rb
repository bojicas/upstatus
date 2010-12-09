class DashboardController < ApplicationController
  def index
    @services = Service.all
  end
end

class DashboardController < ApplicationController
  def index
    @services = Service.all
    @current_issues = Issue.current_issues
  end
end

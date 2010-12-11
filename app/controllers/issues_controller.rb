class IssuesController < ApplicationController
  before_filter :authenticate_admin!, :except => [:index]

  def index
    @issues = Issue.all
  end

  def new
    @issue = Issue.new
  end

  def create
    @issue = Issue.new(params[:issue])
    if @issue.save
      flash[:notice] = "The issue was created successfully."
      redirect_to :action => :index
    else
      render :action => "new"
    end
  end
end

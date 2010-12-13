class IssuesController < ApplicationController
  before_filter :authenticate_admin!, :except => [:index]

  def index
    @issues = Issue.ordered
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

  def edit
    @issue = Issue.find(params[:id])
  end

  def update
    @issue = Issue.find(params[:id])
    if @issue.update_attributes(params[:issue])
      flash[:notice] = "The issue was updated successfully."
      redirect_to :action => :index
    else
      render :action => :edit
    end
  end
  
  def destroy
    issue = Issue.find(params[:id])
    issue.destroy
    redirect_to :action => :index
    flash[:notice] = "The issue was destroyed successfully."
  end     
end

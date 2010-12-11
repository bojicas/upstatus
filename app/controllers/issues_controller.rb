class IssuesController < ApplicationController
  before_filter :authenticate_admin!, :except => [:index]

  def index
    @issues = Issue.all
  end

  def new
    @issue = Issue.new
  end
end

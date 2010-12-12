require 'spec_helper'

describe Issue do
  before(:each) do
    Service.delete_all
    @service = Service.create(
      :id => "1",
      :title => "cubicleapps.com - main",
      :description => "Main application site"
    )
    @issue = Issue.new(
      :service_id => "1",
      :title => "Hardware Failure",
      :severity => 4,
      :description => "The harddisk array is down. Migrating to the cloud services.",
      #:time_down => DateTime.now - 2.hours,
      #:estimate => "2h",
      :resolved => false,
      :time_up => "2010-12-11 09:55:38"
    )
  end

  it "is valid with valid attributes" do
    @issue.should be_valid
  end

  it "is not valid without service reference" do
    @issue.service_id = nil
    @issue.should_not be_valid
  end

  it "is not valid when references an inexistent service" do
    Service.delete_all
    @issue.should_not be_valid
  end

  it "is not valid without title" do
    @issue.title = nil
    @issue.should_not be_valid
  end

  it "is not valid when severity is less than 1" do
    @issue.severity = 0
    @issue.should_not be_valid
  end

  it "is not valid when severity is more than 5" do
    @issue.severity = 6
    @issue.should_not be_valid
  end

  it "is not valid to have time up when issue is not resolved" do
    @issue.save
    @issue.time_up.should be_nil
  end
end

require 'spec_helper'

describe Issue do
  before(:each) do
    @issue = Factory.build(:issue)
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

  it "is not valid without severity status" do
    @issue.severity = nil
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
    @issue.time_up = "2010-12-12 07:04:00"
    @issue.save
    @issue.time_up.should be_nil
  end
end

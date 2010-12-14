require 'spec_helper'

describe Service do
  before(:each) do
    @service = Factory.build(:service)
  end

  it "is valid with valid attributes" do
    @service.should be_valid
  end

  it "is not valid without title" do
    @service.title = nil
    @service.should_not be_valid
  end

  it "is not valid if title exists" do
    @service.save
    Service.new(:title => "cubicleapps.com - main").should_not be_valid
  end
end

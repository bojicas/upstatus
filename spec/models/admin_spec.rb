require 'spec_helper'

describe Admin do
  before(:each) do
    @admin = Admin.new(
      :email => 'admin@cubicleapps.com',
      :password => 'secretpass',
      :password_confirmation => 'secretpass'
    )
  end

  it "is valid with valid attributes" do
    @admin.should be_valid
  end

  it "is not valid without email" do
    @admin.email = nil
    @admin.should_not be_valid
  end

  it "is not valid without password" do
    @admin.password = nil
    @admin.should_not be_valid
  end

  it "is not valid with password less than 6 characters" do
    @admin.password = "passw"
    @admin.should_not be_valid
  end
end

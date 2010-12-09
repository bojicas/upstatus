require 'spec_helper'

describe DashboardController do

  describe "GET 'index'" do
    before do
      @services = mock_model(Service)
      Service.stub(:all).and_return(@services)
    end

    def do_get
      get 'index'
    end

    it "should be successful" do
      do_get
      response.should be_success
    end

    it "should render index template" do
      do_get
      response.should render_template(:index)
    end

    it "should find all services" do
      Service.should_receive(:all).and_return(@services)
      do_get
    end

    it "should assign found services for the view" do
      do_get
      assigns[:services].should == @services
    end
  end

end

require 'spec_helper'

describe ServicesController do

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

    it "should be successful" do
      do_get
      response.should be_success
    end
  end

end

require 'spec_helper'

describe DashboardController do

  describe "GET 'index'" do

    before do
      @services = mock_model(Service)
      @current_issues = mock_model(Issue)
      Service.stub(:all).and_return(@services)
      Issue.stub(:current_issues).and_return(@current_issues)
    end

    def do_get
      get 'index'
    end

    it "is successful" do
      do_get
      response.should be_success
    end

    it "renders index template" do
      do_get
      response.should render_template(:index)
    end

    it "finds all services" do
      Service.should_receive(:all).and_return(@services)
      do_get
    end

    it "finds all current issues" do
      Issue.should_receive(:current_issues).and_return(@current_issues)
      do_get
    end

    it "assigns found services for the view" do
      do_get
      assigns[:services].should == @services
    end

    it "assigns current issues for the view" do
      do_get
      assigns[:current_issues].should == @current_issues
    end
  end

end

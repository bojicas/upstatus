require 'spec_helper'

describe ServicesController do

  describe "access control" do
    [:index, :new].each do |action|
      it "requires admin to be logged in for action #{action}" do
        get action
        flash[:alert].should == "You need to sign in or sign up before continuing."
        response.should redirect_to(new_admin_session_path)
      end
    end
  end

  describe "actions" do
    before do
      login_admin
    end

    def login_admin
      @admin = Admin.create(:email => "admin@cubicleapps.com", :password => "secretpass", :password_confirmation => "secretpass")
      sign_in @admin
    end

    describe "GET 'index'" do
      before do
        @services = mock_model(Service)
        Service.stub(:all).and_return(@services)
      end
      def do_get
        get :index
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

    describe "GET 'new'" do
      before do
        @service = mock_model(Service)
        Service.stub(:new).and_return(@service)
      end
      def do_get
        get :new
      end

      it "should render new template" do
        get :new
        response.should render_template(:new)
      end
      it "should intialize service" do
        Service.should_receive(:new).and_return(@service)
        get :new
      end
      it "should assign service for the view" do
        get :new
        assigns[:service].should == @service
      end

    end

  end




end

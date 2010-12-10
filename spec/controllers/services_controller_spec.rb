require 'spec_helper'

describe ServicesController do

  describe "access control" do
    [:index, :new, :create].each do |action|
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
      @admin = Admin.create(
        :email => "admin@cubicleapps.com",
        :password => "secretpass",
        :password_confirmation => "secretpass"
      )
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
      it "assigns found services for the view" do
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

      it "renders new template" do
        get :new
        response.should render_template(:new)
      end
      it "intializes service" do
        Service.should_receive(:new).and_return(@service)
        get :new
      end
      it "assigns service for the view" do
        get :new
        assigns[:service].should == @service
      end
    end

    describe "POST 'create'" do
      before do
        @service = mock_model(Service).as_null_object
        Service.stub(:new).and_return(@service)
      end

      it "creates a new service" do
        Service.should_receive(:new).with(
          "title" => "cubicleapps.com - main", 
          "description" => "Main application site"
        ).and_return(@service) 
        post :create, :service => { 
          "title" => "cubicleapps.com - main", 
          "description" => "Main application site" 
        }
      end

      context "when the service saves successfully" do
        before do
          @service.stub(:save).and_return(true)
        end
        it "sets a flash[:notice] message" do
          post :create
          flash[:notice].should eq("The service was created successfully.")
        end
        it "redirects to Services index" do
          post :create
          response.should redirect_to(:action => :index)
        end
      end

      context "when the service fails to save" do
        before do
          @service.stub(:save).and_return(false)
        end
        it "assigns @service for the new view" do
          post :create
          assigns[:service].should eq(@service)
        end
        it "renders the new template and displays error messages" do
          post :create
          response.should render_template(:new)
        end
      end
      
    end

  end

end

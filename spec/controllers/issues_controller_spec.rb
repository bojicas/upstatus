require 'spec_helper'

describe IssuesController do

  describe "access control" do
    [:new, :create].each do |action|
      it "requires admin to be logged in for action #{action}" do
        get action, :id => 1
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
        @issues = mock_model(Issue)
        Issue.stub(:all).and_return(@issues)
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
      it "finds all issues" do
        Issue.should_receive(:all).and_return(@issues)
        do_get
      end
      it "assigns found issues for the view" do
        do_get
        assigns[:issues].should == @issues
      end
    end

    describe "GET 'new'" do
      before do
        @issue = mock_model(Issue)
        Issue.stub(:new).and_return(@issue)
      end
      def do_get
        get :new
      end

      it "renders new template" do
        get :new
        response.should render_template(:new)
      end
      it "intializes issue" do
        Issue.should_receive(:new).and_return(@issue)
        get :new
      end
      it "assigns issue for the view" do
        get :new
        assigns[:issue].should == @issue
      end
    end

    describe "POST 'create'" do
      before do
        Service.create(
          :id => "1",
          :title => "cubicleapps.com - main" 
        ) 
        @issue = mock_model(Issue).as_null_object
        Issue.stub(:new).and_return(@issue)
      end

      it "creates a new issue" do

        Issue.should_receive(:new).with(
          "service_id" => "1",
          "title" => "Hardware Failure", 
          "resolved" => false
        ).and_return(@issue) 
        post :create, :issue => { 
          "service_id" => "1",
          "title" => "Hardware Failure", 
          "resolved" => false
        }
      end
      context "when the issue saves successfully" do
        before do
          @issue.stub(:save).and_return(true)
        end
        it "sets a flash[:notice] message" do
          post :create
          flash[:notice].should eq("The issue was created successfully.")
        end
        it "redirects to Issues index" do
          post :create
          response.should redirect_to(:action => :index)
        end
      end
      context "when the issue fails to save" do
        before do
          @issue.stub(:save).and_return(false)
        end
        it "assigns @issue for the new view" do
          post :create
          assigns[:issue].should eq(@issue)
        end
        it "renders the new template" do
          post :create
          response.should render_template(:new)
        end
      end
    end

                           
  end
end

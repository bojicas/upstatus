require 'spec_helper'

describe IssuesController do

  describe "access control" do
    [:new, :create, :edit, :update, :destroy].each do |action|
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
      create_service
    end

    def login_admin
      sign_in Factory(:admin)
    end

    def create_service
      Factory(:service, :id => "1") 
    end

    describe "GET 'index'" do
      before do
        @issues = mock_model(Issue)
        Issue.stub(:ordered).and_return(@issues)
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
        Issue.should_receive(:ordered).and_return(@issues)
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
        @issue = mock_model(Issue).as_null_object
        Issue.stub(:new).and_return(@issue)
      end

      it "creates a new issue" do
        Issue.should_receive(:new).with(
          "service_id" => "1",
          "title" => "Hardware Failure", 
          "resolved" => false,
          "time_up" => "2010-12-12 07:28:15"
        ).and_return(@issue) 
        post :create, :issue => { 
          "service_id" => "1",
          "title" => "Hardware Failure", 
          "resolved" => false,
          "time_up" => "2010-12-12 07:28:15"
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

    describe "GET 'edit'" do
      before do
        @issue = mock_model(Issue)
        Issue.stub!(:find).with("1").and_return(@issue)
      end
      def do_get
        get :edit, :id => "1"
      end

      it "renders new template" do
        do_get
        response.should render_template(:edit)
      end
      it "intializes issue with found record" do
        Issue.should_receive(:find).with("1").and_return(@issue)
        do_get
      end
      it "assigns issue for the view" do
        do_get
        assigns[:issue].should == @issue
      end
    end
    
    describe "POST 'update'" do
      before do
        @issue = mock_model(Issue, :update_attributes => true)
        Issue.stub!(:find).with("1").and_return(@issue)
      end


      it "finds issue to update" do
        Issue.should_receive(:find).with("1").and_return(@issue)
        post :update, :id => "1", :issue => { :title => "Maintenance" } 
      end                

      context "when the issue saves successfully" do
        before do
          @issue.stub(:update_attributes).and_return(true)
        end
        it "sets a flash[:notice] message" do
          post :update, :id => "1"
          flash[:notice].should eq("The issue was updated successfully.")
        end
        it "redirects to issues index" do
          post :update, :id => "1"
          response.should redirect_to(:action => :index)
        end
      end
      context "when the issue fails to save" do
        before do
          @issue.stub(:update_attributes).and_return(false)
        end
        it "assigns @issue for the edit view" do
          post :update, :id => "1"
          assigns[:issue].should eq(@issue)
        end
        it "renders the edit template" do
          post :update, :id => "1"
          response.should render_template(:edit)
        end
      end
    end

    describe "DELETE 'destroy'" do
      before do
        @issue = mock_model(Issue)
        Issue.stub!(:find).with("1").and_return(@issue)     
      end
      
      it "finds the issue record to destroy" do
        Issue.should_receive(:find).with("1").and_return(@issue)
        delete :destroy, :id => "1"
      end
      it "destroys the issue" do
        @issue.should_receive(:destroy).and_return(true)
        delete :destroy, :id => "1"
      end
      it "redirects to Issue index" do
        delete :destroy, :id => "1"
        response.should redirect_to(:action => :index)
      end
      it "set a flash[:notice] message" do
        delete :destroy, :id => "1"
        flash[:notice].should eq("The issue was destroyed successfully.")
      end
    end                    

  end
end

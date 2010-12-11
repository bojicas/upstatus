require 'spec_helper'

describe IssuesController do

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


end

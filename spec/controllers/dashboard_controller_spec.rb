require 'spec_helper'

describe DashboardController do

  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should render_template(:index)
      response.should be_success
    end
  end

end

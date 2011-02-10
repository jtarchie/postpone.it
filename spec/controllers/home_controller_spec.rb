require 'spec_helper'

describe HomeController do
  describe "when user is logged in" do
    before do
      sign_in(users(:user))
    end

    context "GET #show" do
      it "should return a success" do
        get :show
        response.should be_success
      end
    end
  end
end

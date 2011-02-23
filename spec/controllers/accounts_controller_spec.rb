require 'spec_helper'

describe AccountsController do
  describe "when a user is logged in" do

    before do
      @user = users(:user)
      sign_in @user
    end

    describe "GET #index" do
      before {get :index}

      it "should return successfully" do
        response.should be_success
      end
    end
  end
end

require 'spec_helper'

describe User do
  it "should be a valid Factory" do
    Factory.build(:user).should be_valid
  end

  it "should have a user fixture" do
    users(:user).should be_valid
  end

  describe "associations" do
    before do
      @user = users(:user)
    end
    context "authorizations" do
      it "should delete on user destroy" do
        @user.authorizations.create(:provider => "test", :uid => "test")
        expect {
          @user.destroy
        }.should change(Authorization, :count).by(-1)
      end
    end
  end
end

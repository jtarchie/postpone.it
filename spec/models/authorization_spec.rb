require 'spec_helper'

describe Authorization do
  it "should have a valid Factory" do
    Factory.build(:authorization).should be_valid
  end

  describe "associations" do
    it "should return a list based on provider" do
      facebook = Factory(:authorization, :provider => "facebook")
      Factory(:authorization, :provider => "twitter")
      Authorization.provider("facebook").should == [facebook]
    end
  end

  describe "validations" do
    it "should only allow one provider and UID per user" do
      user = users(:user)
      Factory(:authorization, :user => user, :provider => "provider", :uid => "uid")
      Factory.build(:authorization, :user => user, :provider => "provider", :uid => "uid").should_not be_valid
    end
  end
end

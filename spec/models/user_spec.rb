require 'spec_helper'

describe User do
  it "should be a valid Factory" do
    Factory.build(:user).should be_valid
  end

  it "should have a user fixture" do
    users(:user).should be_valid
  end
end

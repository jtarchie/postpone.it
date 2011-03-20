require 'spec_helper'

describe User do
  it "should be a valid Factory" do
    Factory.build(:user).should be_valid
  end

  it "should have a user fixture" do
    users(:user).should be_valid
  end

  describe "associations" do
    it {should have_many(:authorizations).dependent(:delete_all)}
    it {should have_many(:videos).dependent(:destroy)}
  end
end

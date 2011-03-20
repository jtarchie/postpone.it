require 'spec_helper'

describe Video do
  it "should have a valid Factory" do
    Factory.build(:video).should be_valid
  end
  
  describe" validations" do
    it "should require url, title, and description" do
      [:url, :title, :description].each do |attribute|
        Factory.build(:video, attribute => nil).should have(1).error_on(attribute)
      end
    end
  end
end

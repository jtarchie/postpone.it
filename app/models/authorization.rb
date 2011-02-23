class Authorization < ActiveRecord::Base
  belongs_to :user

  validates_uniqueness_of :user_id, :scope => [:provider, :uid]

  scope :provider, lambda {|name| where(:provider => name)}
end

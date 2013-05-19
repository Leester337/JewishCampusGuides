class EventCreator < ActiveRecord::Base
  belongs_to :college
  belongs_to :organization
  attr_accessible :fb_id, :name, :college_id, :cal_id, :organization_id
end

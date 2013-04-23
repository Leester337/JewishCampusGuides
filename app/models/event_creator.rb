class EventCreator < ActiveRecord::Base
  belongs_to :college
  #has_many :event
  attr_accessible :fb_id, :name, :college_id, :cal_id
end

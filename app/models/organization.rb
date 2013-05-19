class Organization < ActiveRecord::Base
  belongs_to :venue
  has_many :event_creator
  belongs_to :college
  attr_accessible :description, :name, :num_staff, :yr_established, :website, :college_id, :venue_id, :picture
end

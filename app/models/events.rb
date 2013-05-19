class Events < ActiveRecord::Base
  has_one :venue, :foreign_key => 'id', :primary_key => 'venue_id'
  belongs_to :event_creator
  belongs_to :national_stats
  attr_accessible :description, :fb_event_id, :google_event_id, :venue_id, :end_time, :id, :location, :name, :picture, :privacy, :start_time, :ticket_uri, :updated_time, :numAttending, :numInvited, :numMaybe, :event_creator_id
end

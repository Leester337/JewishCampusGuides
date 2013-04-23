class Venue < ActiveRecord::Base
	belongs_to :events, :foreign_key => 'id', :primary_key => 'venue_id'
	#alias_attribute :events_id, :venue_id
	attr_accessible :city, :country, :vid, :latitude, :longitude, :street, :zip, :state
end

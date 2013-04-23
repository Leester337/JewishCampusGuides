class AddEventCreatorsToEvents < ActiveRecord::Migration
  def change
  	change_table :events do |t|
    	t.references :event_creators
  	end
  end
end

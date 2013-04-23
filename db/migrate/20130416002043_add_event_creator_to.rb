class AddEventCreatorTo < ActiveRecord::Migration
  def change
  	add_column :events, :event_creator_id, :integer
  end
end

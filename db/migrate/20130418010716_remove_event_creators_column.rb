class RemoveEventCreatorsColumn < ActiveRecord::Migration
  def change
  	remove_column :events, :event_creators_id
  end
end

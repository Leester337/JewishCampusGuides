class AddColumnToEvents < ActiveRecord::Migration
  def change
  	remove_column :events, :location
  	add_column :events, :numAttending, :integer
  	add_column :events, :numInvited, :integer
  	add_column :events, :numMaybe, :integer
  	add_column :events, :eid, :integer
  end
end

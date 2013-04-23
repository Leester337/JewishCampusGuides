class AddCalIdToEventCreator < ActiveRecord::Migration
  def change
  	add_column :event_creators, :calID, :string
  end
end

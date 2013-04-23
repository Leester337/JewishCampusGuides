class ChangeColumnsEvents < ActiveRecord::Migration
  def change
  	add_column :events, :google_event_id, :string
  	rename_column :events, :eid, :fb_event_id
  end
end

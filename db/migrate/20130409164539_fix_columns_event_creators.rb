class FixColumnsEventCreators < ActiveRecord::Migration
  def up
  	#add_column :event_creators, :fb_id, :string
  	remove_column :event_creators, :fbId
  	
  	#rename_column :event_creators, :calID, :cal_id
  end

  def down
  	add_column :event_creators, :fbId, :string
  end
end

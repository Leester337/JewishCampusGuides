class ChangeEventCreatorIdNames < ActiveRecord::Migration
  def change
  	change_column :event_creators, :fbId, :fb_id
  	#change_column :event_creators, :calID, :cal_id
  end
end

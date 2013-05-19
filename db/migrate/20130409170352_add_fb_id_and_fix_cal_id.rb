class AddFbIdAndFixCalId < ActiveRecord::Migration
  def change
  	add_column :event_creators, :fb_id, :string
  	rename_column :event_creators, :calID, :cal_id
  end
end

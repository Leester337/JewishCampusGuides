class DropcollegeNicknameFromEventCreators < ActiveRecord::Migration
  def change
  	remove_column :event_creators, :collegeNickname
  end
end

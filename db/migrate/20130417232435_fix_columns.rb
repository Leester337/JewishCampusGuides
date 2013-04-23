class FixColumns < ActiveRecord::Migration
  def change
  	add_column :venues, :vid, :string
  	remove_column :events, :event_creator
  end
end

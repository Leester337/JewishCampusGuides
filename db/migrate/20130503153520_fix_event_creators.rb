class FixEventCreators < ActiveRecord::Migration
  def change
  	change_table :event_creators do |t|
    	t.references :organizations
  	end

  	remove_column :organizations, :event_creators_id
  end
end

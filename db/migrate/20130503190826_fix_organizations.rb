class FixOrganizations < ActiveRecord::Migration
  def change
  	remove_column :organizations, :colleges_id
  	rename_column :organizations, :num_yrs_on_campus, :yr_established
  	remove_column :event_creators, :organizations_id

  	change_table :organizations do |t|
    	t.references :college
  	end

  	change_table :event_creators do |t|
    	t.references :organization
  	end
  end
end

class AddCollegesToOrganization < ActiveRecord::Migration
  def change
  	change_table :organizations do |t|
    	t.references :colleges
  	end
  end
end

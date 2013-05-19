class RemoveColumns < ActiveRecord::Migration
  def change
  	remove_column :events, :person_id
  	add_column :venues, :name, :string
  end
end

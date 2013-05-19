class RemoveColumnInterests < ActiveRecord::Migration
  def change
  	remove_column :prospective_students, :interests
  end
end

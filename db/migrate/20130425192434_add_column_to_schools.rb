class AddColumnToSchools < ActiveRecord::Migration
  def change
  	add_column :schools, :fid, :string
  end
end

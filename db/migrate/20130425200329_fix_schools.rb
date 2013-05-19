class FixSchools < ActiveRecord::Migration
  def change
  	change_column :schools, :type, :string
  	rename_column :schools, :type, :school_type
  end
end

class ChangeTypeName < ActiveRecord::Migration
  def change
  	change_column :schools, :type, :schooltype
  end
end

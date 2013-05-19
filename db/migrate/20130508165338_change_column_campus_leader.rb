class ChangeColumnCampusLeader < ActiveRecord::Migration
  def change
  	rename_column :campus_leaders, :sigificant_other, :significant_other
  end
end

class AddFidToCampusLeaders < ActiveRecord::Migration
  def change
    add_column :campus_leaders, :fid, :string
  end
end

class AddGCalUrlToCollege < ActiveRecord::Migration
  def change
  	add_column :colleges, :gcalURL, :string
  end
end

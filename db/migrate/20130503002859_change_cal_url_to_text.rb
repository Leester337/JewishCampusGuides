class ChangeCalUrlToText < ActiveRecord::Migration
  def change
  	change_column :colleges, :gcalURL, :text
  end
end

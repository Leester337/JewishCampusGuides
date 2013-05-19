class AddImageUrlToColleges < ActiveRecord::Migration
  def change
  	add_column :colleges, :imageURL, :string
  end
end

class AddColumnToColleges < ActiveRecord::Migration
  def change
    add_column :colleges, :rep_email, :string
  end
end

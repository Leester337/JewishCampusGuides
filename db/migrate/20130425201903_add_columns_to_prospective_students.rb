class AddColumnsToProspectiveStudents < ActiveRecord::Migration
  def change
    add_column :prospective_students, :major, :string
    remove_column :prospective_students, :education
  end
end

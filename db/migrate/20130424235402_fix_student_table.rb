class FixStudentTable < ActiveRecord::Migration
	def change
		drop_table :people

		add_column :prospective_students, :interests, :string
		add_column :prospective_students, :share_with_orgs, :boolean
		
		create_table :education do |t|
			t.string :name
			t.string :type
		end

		create_table :schooled do |t|
			t.references :education
			t.integer :year
			t.string :degree
			t.string :concentration
			t.references :prospective_students
		end
	end
end

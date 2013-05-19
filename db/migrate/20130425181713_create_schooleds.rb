class CreateSchooleds < ActiveRecord::Migration
  def change
    create_table :schooleds do |t|
      t.integer :year
      t.string :degree
      t.string :concentration
      t.references :prospective_student
      t.references :school

      t.timestamps
    end
    add_index :schooleds, :prospective_student_id
    add_index :schooleds, :school_id
  end
end

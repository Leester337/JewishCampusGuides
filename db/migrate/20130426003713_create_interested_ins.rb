class CreateInterestedIns < ActiveRecord::Migration
  def change
    create_table :interested_ins do |t|
      t.references :prospective_student
      t.references :interest

      t.timestamps
    end
    add_index :interested_ins, :prospective_student_id
    add_index :interested_ins, :interest_id
  end
end

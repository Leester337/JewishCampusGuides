class CreateSchools < ActiveRecord::Migration
  def change
    create_table :schools do |t|
      t.string :name
      t.string :type

      t.timestamps
    end

    drop_table :education
    drop_table :schooled
  end
end

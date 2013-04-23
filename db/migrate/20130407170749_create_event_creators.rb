class CreateEventCreators < ActiveRecord::Migration
  def change
    create_table :event_creators do |t|
      t.string :fbId
      t.references :college
      t.string :name
      t.string :collegeNickname

      t.timestamps
    end
    add_index :event_creators, :college_id
  end
end

class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :id
      t.string :name
      t.references :person
      t.string :description
      t.string :start_time
      t.string :end_time
      t.string :location
      t.references :venue
      t.string :privacy
      t.string :updated_time
      t.string :picture
      t.string :ticket_uri

      t.timestamps
    end
    add_index :events, :person_id
    add_index :events, :venue_id
  end
end

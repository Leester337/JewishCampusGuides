class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.string :name
      t.references :venue
      t.text :description
      t.string :website
      t.integer :num_yrs_on_campus
      t.integer :num_staff
      t.references :event_creators

      t.timestamps
    end
    add_index :organizations, :venue_id
    add_index :organizations, :event_creators_id
  end
end

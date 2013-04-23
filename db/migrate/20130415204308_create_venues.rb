class CreateVenues < ActiveRecord::Migration
  def change
    create_table :venues do |t|
      t.string :id
      t.string :street
      t.string :city
      t.string :zip
      t.string :country
      t.string :latitude
      t.string :longitude

      t.timestamps
    end
  end
end

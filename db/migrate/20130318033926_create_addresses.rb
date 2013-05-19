class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :id
      t.string :street
      t.string :city
      t.string :state
      t.string :zip
      t.string :country
      t.string :latitude
      t.string :longitude

      t.timestamps
    end
  end
end

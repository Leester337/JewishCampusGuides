class CreateNationalTable < ActiveRecord::Migration
  def change
    create_table :national_stats do |t|
      t.integer :rank
      t.references :events

      t.timestamps
    end
	end
end

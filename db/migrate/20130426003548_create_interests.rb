class CreateInterests < ActiveRecord::Migration
  def change
    create_table :interests do |t|
      t.string :fid
      t.string :name
      t.string :category

      t.timestamps
    end
  end
end

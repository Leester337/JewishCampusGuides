class CreateCampusLeaders < ActiveRecord::Migration
  def change
    create_table :campus_leaders do |t|
      t.string :name
      t.string :picture
      t.string :link
      t.references :organization
      t.string :bio
      t.string :email
      t.string :hometown
      t.string :sigificant_other
      t.string :quote

      t.timestamps
    end
    add_index :campus_leaders, :organization_id
  end
end

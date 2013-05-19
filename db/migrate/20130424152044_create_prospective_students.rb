class CreateProspectiveStudents < ActiveRecord::Migration
  def change
    create_table :prospective_students do |t|
      t.string :provider
      t.string :uid
      t.string :name
      t.string :oauth_token
      t.datetime :oauth_expires_at
      t.string :gender
      t.string :link
      t.string :bio
      t.string :education
      t.string :email
      t.string :hometown
      t.string :location

      t.timestamps
    end
  end
end

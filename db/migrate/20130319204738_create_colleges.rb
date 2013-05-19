class CreateColleges < ActiveRecord::Migration
  def change
    create_table :colleges do |t|
      t.string :name
      t.string :nickname
      t.integer :popUndergrad
      t.integer :popGrad
      t.integer :programsOfStudy
      t.integer :uniqueCourses
      t.integer :studyAbroad
      t.integer :jewishPopUndergrad
      t.integer :jewishPopGrad
      t.boolean :jewishMinor
      t.boolean :jewishMajor
      t.integer :jewishCourses
      t.integer :israelStudyAbroad

      t.timestamps
    end
  end
end

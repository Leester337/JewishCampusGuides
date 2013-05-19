# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130512150500) do

  create_table "campus_leaders", :force => true do |t|
    t.string   "name"
    t.string   "picture"
    t.string   "link"
    t.integer  "organization_id"
    t.string   "bio"
    t.string   "email"
    t.string   "hometown"
    t.string   "significant_other"
    t.string   "quote"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.string   "fid"
  end

  add_index "campus_leaders", ["organization_id"], :name => "index_campus_leaders_on_organization_id"

  create_table "colleges", :force => true do |t|
    t.string   "name"
    t.string   "nickname"
    t.integer  "popUndergrad"
    t.integer  "popGrad"
    t.integer  "programsOfStudy"
    t.integer  "uniqueCourses"
    t.integer  "studyAbroad"
    t.integer  "jewishPopUndergrad"
    t.integer  "jewishPopGrad"
    t.boolean  "jewishMinor"
    t.boolean  "jewishMajor"
    t.integer  "jewishCourses"
    t.integer  "israelStudyAbroad"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.string   "imageURL"
    t.text     "gcalURL",            :limit => 255
    t.string   "rep_email"
  end

  create_table "event_creators", :force => true do |t|
    t.integer  "college_id"
    t.string   "name"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "cal_id"
    t.string   "fb_id"
    t.integer  "organization_id"
  end

  add_index "event_creators", ["college_id"], :name => "index_event_creators_on_college_id"

  create_table "events", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "start_time"
    t.string   "end_time"
    t.integer  "venue_id"
    t.string   "privacy"
    t.string   "updated_time"
    t.string   "picture"
    t.string   "ticket_uri"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "event_creator_id"
    t.integer  "numAttending"
    t.integer  "numInvited"
    t.integer  "numMaybe"
    t.integer  "fb_event_id"
    t.string   "location"
    t.string   "google_event_id"
  end

  add_index "events", ["venue_id"], :name => "index_events_on_venue_id"

  create_table "interested_ins", :force => true do |t|
    t.integer  "prospective_student_id"
    t.integer  "interest_id"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
  end

  add_index "interested_ins", ["interest_id"], :name => "index_interested_ins_on_interest_id"
  add_index "interested_ins", ["prospective_student_id"], :name => "index_interested_ins_on_prospective_student_id"

  create_table "interests", :force => true do |t|
    t.string   "fid"
    t.string   "name"
    t.string   "category"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "organizations", :force => true do |t|
    t.string   "name"
    t.integer  "venue_id"
    t.text     "description"
    t.string   "website"
    t.integer  "yr_established"
    t.integer  "num_staff"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "college_id"
    t.string   "picture"
  end

  add_index "organizations", ["venue_id"], :name => "index_organizations_on_venue_id"

  create_table "prospective_students", :force => true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.string   "gender"
    t.string   "link"
    t.string   "bio"
    t.string   "email"
    t.string   "hometown"
    t.string   "location"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.boolean  "share_with_orgs"
    t.string   "major"
  end

  create_table "rails_admin_histories", :force => true do |t|
    t.text     "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month",      :limit => 2
    t.integer  "year",       :limit => 5
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], :name => "index_rails_admin_histories"

  create_table "schooleds", :force => true do |t|
    t.integer  "year"
    t.string   "degree"
    t.string   "concentration"
    t.integer  "prospective_student_id"
    t.integer  "school_id"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
  end

  add_index "schooleds", ["prospective_student_id"], :name => "index_schooleds_on_prospective_student_id"
  add_index "schooleds", ["school_id"], :name => "index_schooleds_on_school_id"

  create_table "schools", :force => true do |t|
    t.string   "name"
    t.string   "school_type"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "fid"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "venues", :force => true do |t|
    t.string   "street"
    t.string   "city"
    t.string   "zip"
    t.string   "country"
    t.string   "latitude"
    t.string   "longitude"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "name"
    t.string   "vid"
    t.string   "state"
  end

end

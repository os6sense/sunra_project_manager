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

ActiveRecord::Schema.define(:version => 20130723094611) do

  create_table "admins", :force => true do |t|
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
    t.string   "authentication_token"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "admins", ["authentication_token"], :name => "index_admins_on_authentication_token", :unique => true
  add_index "admins", ["email"], :name => "index_admins_on_email", :unique => true
  add_index "admins", ["reset_password_token"], :name => "index_admins_on_reset_password_token", :unique => true

  create_table "booking_companies", :force => true do |t|
    t.string   "company_name"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "booking_contact_details", :force => true do |t|
    t.integer  "booking_contact_id"
    t.string   "email_or_phone"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "booking_contacts", :force => true do |t|
    t.integer  "booking_company_id"
    t.string   "contact_name"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "bookings", :force => true do |t|
    t.string   "project_id",         :null => false
    t.integer  "facility_studio",    :null => false
    t.date     "date",               :null => false
    t.datetime "start_time",         :null => false
    t.datetime "end_time",           :null => false
    t.text     "availability_notes"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "client_logins", :force => true do |t|
    t.string   "project_id",      :null => false
    t.string   "login_email"
    t.string   "password_digest"
    t.string   "recoverable"
    t.string   "key_name"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "distribution_audits", :force => true do |t|
    t.integer  "format_id"
    t.string   "email_address"
    t.datetime "emailed_at"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "file_op_messages", :force => true do |t|
    t.string   "message"
    t.boolean  "is_error"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "file_ops_audits", :force => true do |t|
    t.datetime "encryption_started_at"
    t.integer  "encryption_progress"
    t.datetime "encrypted_at"
    t.datetime "uploaded_started_at"
    t.integer  "upload_progress"
    t.datetime "uploaded_at"
    t.datetime "copy_started_at"
    t.integer  "copy_progress"
    t.datetime "copied_at"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  create_table "format_lookups", :force => true do |t|
    t.string   "name"
    t.string   "extension"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "projects", :id => false, :force => true do |t|
    t.string   "uuid",         :null => false
    t.string   "client_name",  :null => false
    t.string   "project_name", :null => false
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "recording_formats", :force => true do |t|
    t.integer  "recording_id"
    t.integer  "format",                              :null => false
    t.string   "directory",                           :null => false
    t.string   "remote_directory"
    t.integer  "filesize",         :default => 0
    t.datetime "start_time",                          :null => false
    t.datetime "end_time"
    t.string   "sha1hash"
    t.boolean  "upload",           :default => false
    t.boolean  "copy",             :default => false
    t.boolean  "encrypt",          :default => false
    t.boolean  "encrypted",        :default => false
    t.boolean  "fixed_moov_atom",  :default => false
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
  end

  create_table "recordings", :force => true do |t|
    t.integer  "booking_id",    :null => false
    t.datetime "start_time",    :null => false
    t.datetime "end_time"
    t.integer  "group_number",  :null => false
    t.string   "base_filename", :null => false
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "studio_lookups", :force => true do |t|
    t.string   "facility_name"
    t.string   "studio_name"
    t.string   "mdns_localname"
    t.string   "ip_fallback"
    t.string   "phone"
    t.boolean  "active"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

end

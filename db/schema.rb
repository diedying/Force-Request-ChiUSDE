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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170414191552) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "uin"
    t.string "name"
    t.string "password"
  end

  create_table "audits", force: :cascade do |t|
    t.integer  "auditable_id"
    t.string   "auditable_type"
    t.integer  "associated_id"
    t.string   "associated_type"
    t.integer  "user_id"
    t.string   "user_type"
    t.string   "username"
    t.string   "action"
    t.text     "audited_changes"
    t.integer  "version",         default: 0
    t.string   "comment"
    t.string   "remote_address"
    t.string   "request_uuid"
    t.datetime "created_at"
  end

  add_index "audits", ["associated_id", "associated_type"], name: "associated_index", using: :btree
  add_index "audits", ["auditable_id", "auditable_type"], name: "auditable_index", using: :btree
  add_index "audits", ["created_at"], name: "index_audits_on_created_at", using: :btree
  add_index "audits", ["request_uuid"], name: "index_audits_on_request_uuid", using: :btree
  add_index "audits", ["user_id", "user_type"], name: "user_index", using: :btree

  create_table "majors", force: :cascade do |t|
    t.string "major_id"
  end

  create_table "student_request_archivals", force: :cascade do |t|
    t.string   "request_id"
    t.string   "uin"
    t.string   "name"
    t.string   "major"
    t.string   "classification"
    t.string   "minor"
    t.string   "email"
    t.string   "phone"
    t.string   "expected_graduation"
    t.string   "request_semester"
    t.string   "course_id"
    t.string   "section_id"
    t.text     "notes"
    t.string   "state"
    t.string   "priority"
    t.datetime "creation_date"
    t.datetime "last_updated"
    t.text     "notes_to_student"
    t.text     "admin_notes"
  end

  create_table "student_requests", force: :cascade do |t|
    t.string   "request_id"
    t.string   "uin"
    t.string   "name"
    t.string   "major"
    t.string   "classification"
    t.string   "minor"
    t.string   "email"
    t.string   "phone"
    t.string   "expected_graduation"
    t.string   "request_semester"
    t.string   "course_id"
    t.string   "section_id"
    t.text     "notes"
    t.string   "state"
    t.string   "priority"
    t.datetime "creation_date"
    t.datetime "last_updated"
    t.text     "notes_to_student"
    t.text     "admin_notes"
  end

  add_index "student_requests", ["course_id"], name: "index_student_requests_on_course_id", using: :btree
  add_index "student_requests", ["request_id"], name: "index_student_requests_on_request_id", unique: true, using: :btree
  add_index "student_requests", ["section_id"], name: "index_student_requests_on_section_id", using: :btree
  add_index "student_requests", ["state"], name: "index_student_requests_on_state", using: :btree

  create_table "students", force: :cascade do |t|
    t.string   "uin"
    t.string   "password"
    t.string   "major"
    t.string   "classification"
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "email_confirmed",              default: false
    t.string   "confirm_token"
    t.string   "reset_password_confirm_token"
    t.datetime "reset_sent_at"
    t.datetime "email_confirm_sent_at"
  end

end

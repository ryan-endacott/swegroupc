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

ActiveRecord::Schema.define(version: 20140422231038) do

  create_table "assignments", force: true do |t|
    t.string   "name"
    t.integer  "course_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "due_date"
  end

  add_index "assignments", ["course_id"], name: "index_assignments_on_course_id"

  create_table "courses", force: true do |t|
    t.string   "name"
    t.integer  "instructor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "courses", ["instructor_id"], name: "index_courses_on_instructor_id"

  create_table "courses_users", id: false, force: true do |t|
    t.integer "ta_id"
    t.integer "course_id"
  end

  add_index "courses_users", ["ta_id", "course_id"], name: "index_courses_users_on_ta_id_and_course_id", unique: true

  create_table "sections", force: true do |t|
    t.string   "name"
    t.integer  "course_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sections", ["course_id"], name: "index_sections_on_course_id"

  create_table "submission_files", force: true do |t|
    t.string   "filename"
    t.string   "content_type"
    t.binary   "file_contents"
    t.integer  "submission_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "submission_files", ["submission_id"], name: "index_submission_files_on_submission_id"

  create_table "submissions", force: true do |t|
    t.text     "receipt"
    t.integer  "user_id"
    t.text     "ip_address"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "assignment_id"
    t.integer  "section_id"
  end

  add_index "submissions", ["assignment_id"], name: "index_submissions_on_assignment_id"
  add_index "submissions", ["section_id"], name: "index_submissions_on_section_id"
  add_index "submissions", ["user_id"], name: "index_submissions_on_user_id"

  create_table "ta_courses", id: false, force: true do |t|
    t.integer "ta_id"
    t.integer "course_id"
  end

  add_index "ta_courses", ["ta_id", "course_id"], name: "index_ta_courses_on_ta_id_and_course_id", unique: true

  create_table "users", force: true do |t|
    t.string   "email",               default: ""
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",       default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "pawprint",                         null: false
    t.string   "type",                             null: false
    t.string   "encrypted_password"
  end

  add_index "users", ["pawprint"], name: "index_users_on_pawprint", unique: true

end

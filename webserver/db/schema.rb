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

ActiveRecord::Schema.define(version: 20140419213349) do

  create_table "assignments", force: true do |t|
    t.string   "name"
    t.integer  "course_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "assignments", ["course_id"], name: "index_assignments_on_course_id"

  create_table "courses", force: true do |t|
    t.string   "name"
    t.integer  "instructor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "courses", ["instructor_id"], name: "index_courses_on_instructor_id"

  create_table "sections", force: true do |t|
    t.string   "name"
    t.integer  "course_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sections", ["course_id"], name: "index_sections_on_course_id"

  create_table "student_courses", id: false, force: true do |t|
    t.integer "student_id"
    t.integer "course_id"
  end

  add_index "student_courses", ["student_id", "course_id"], name: "index_student_courses_on_student_id_and_course_id", unique: true

  create_table "student_sections", id: false, force: true do |t|
    t.integer "student_id"
    t.integer "section_id"
  end

  add_index "student_sections", ["student_id", "section_id"], name: "index_student_sections_on_student_id_and_section_id", unique: true

  create_table "submissions", force: true do |t|
    t.text     "receipt"
    t.integer  "user_id"
    t.text     "ip_address"
    t.text     "filename"
    t.text     "content_type"
    t.binary   "file_contents"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "assignment_id"
  end

  add_index "submissions", ["assignment_id"], name: "index_submissions_on_assignment_id"
  add_index "submissions", ["user_id"], name: "index_submissions_on_user_id"

  create_table "ta_courses", id: false, force: true do |t|
    t.integer "ta_id"
    t.integer "course_id"
  end

  add_index "ta_courses", ["ta_id", "course_id"], name: "index_ta_courses_on_ta_id_and_course_id", unique: true

  create_table "ta_sections", id: false, force: true do |t|
    t.integer "ta_id"
    t.integer "section_id"
  end

  add_index "ta_sections", ["ta_id", "section_id"], name: "index_ta_sections_on_ta_id_and_section_id", unique: true

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end

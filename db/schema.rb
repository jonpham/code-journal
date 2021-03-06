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

ActiveRecord::Schema.define(version: 20170117081848) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "code_snippets", force: :cascade do |t|
    t.text     "user_source_code"
    t.integer  "module_session_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "lesson_categories", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "lesson_modules", force: :cascade do |t|
    t.integer  "lesson_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "lesson_ordinal"
    t.text     "description"
  end

  create_table "lesson_sessions", force: :cascade do |t|
    t.integer  "lesson_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lessons", force: :cascade do |t|
    t.string   "name"
    t.text     "concept"
    t.text     "purpose"
    t.text     "description"
    t.text     "example"
    t.integer  "lesson_category_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "created_by"
  end

  create_table "module_codes", force: :cascade do |t|
    t.integer  "lesson_module_id"
    t.string   "method_name"
    t.text     "arguments"
    t.string   "return_type"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.text     "source_code"
    t.integer  "module_ordinal"
  end

  create_table "module_sessions", force: :cascade do |t|
    t.integer  "lesson_module_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "lesson_session_id"
  end

  create_table "test_codes", force: :cascade do |t|
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "module_code_id"
    t.string   "assertion_type"
    t.text     "expected_return"
    t.text     "expected_test_data"
    t.text     "description"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "first_name"
    t.string   "last_name"
    t.boolean  "admin",                  default: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

end

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

ActiveRecord::Schema.define(:version => 20130723013653) do

  create_table "authorizations", :force => true do |t|
    t.string   "role"
    t.string   "course"
    t.string   "user"
    t.string   "micropost"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "authorizations", ["role"], :name => "index_authorizations_on_role"

  create_table "coursecreations", :force => true do |t|
    t.integer  "course_id"
    t.integer  "user_id"
    t.string   "role"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "coursecreations", ["course_id"], :name => "index_coursecreations_on_course_id"
  add_index "coursecreations", ["user_id"], :name => "index_coursecreations_on_user_id"

  create_table "coursemods", :force => true do |t|
    t.string   "module_name"
    t.text     "module_desc"
    t.integer  "course_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "coursemod_order"
  end

  add_index "coursemods", ["course_id"], :name => "index_coursemods_on_course_id"

  create_table "courses", :force => true do |t|
    t.string   "course_name"
    t.string   "technology"
    t.string   "level"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.text     "desc"
  end

  create_table "lessons", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.text     "instructions"
    t.text     "solution"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.text     "tips"
  end

  create_table "microposts", :force => true do |t|
    t.string   "content"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "microposts", ["user_id"], :name => "index_microposts_on_user_id"

  create_table "modlessons", :force => true do |t|
    t.integer  "module_id"
    t.integer  "lesson_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "lesson_order"
  end

  add_index "modlessons", ["lesson_id"], :name => "index_module_lessons_on_lesson_id"
  add_index "modlessons", ["module_id"], :name => "index_module_lessons_on_module_id"

  create_table "modularizations", :force => true do |t|
    t.integer  "module_id"
    t.integer  "lesson_id"
    t.integer  "lesson_order"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "relationships", :force => true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "relationships", ["followed_id"], :name => "index_relationships_on_followed_id"
  add_index "relationships", ["follower_id"], :name => "index_relationships_on_follower_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.string   "encrypted_password"
    t.string   "salt"
    t.boolean  "admin",                  :default => false
    t.string   "confirmation_token"
    t.boolean  "confirmed"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.string   "role"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

end

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

ActiveRecord::Schema.define(:version => 20110412204200) do

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "hits", :force => true do |t|
    t.integer  "short_link_id"
    t.string   "ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "referrer"
  end

  create_table "links", :force => true do |t|
    t.integer  "update_id"
    t.integer  "social_account_id"
    t.string   "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "status_type",       :default => 0
    t.string   "status_message"
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  create_table "short_links", :force => true do |t|
    t.string   "url"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "hits",       :default => 0
  end

  create_table "social_accounts", :force => true do |t|
    t.integer  "user_id"
    t.string   "token"
    t.integer  "uid",         :limit => 8
    t.integer  "social_type"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "secret"
    t.string   "login"
    t.string   "password"
  end

  create_table "updates", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.string   "url"
    t.string   "tags"
    t.integer  "user_id"
    t.datetime "publish_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "email"
    t.string   "api_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_type"
  end

end

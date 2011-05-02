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

ActiveRecord::Schema.define(:version => 20110502143954) do

  create_table "albums", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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
    t.datetime "run_every"
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "events", :force => true do |t|
    t.string   "title"
    t.string   "where"
    t.text     "description"
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "flayer_file_name"
    t.string   "flayer_content_type"
    t.integer  "flayer_file_size"
    t.datetime "flayer_updated_at"
  end

  create_table "hits", :force => true do |t|
    t.integer  "short_link_id"
    t.string   "ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "referrer"
  end

  create_table "links", :force => true do |t|
    t.integer  "stream_id"
    t.integer  "social_account_id"
    t.string   "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "status_type",       :default => 0
    t.string   "status_message"
    t.integer  "progress",          :default => 0
    t.integer  "done",              :default => 0
    t.integer  "total",             :default => 0
  end

  create_table "photos", :force => true do |t|
    t.integer  "album_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.boolean  "image_processing"
  end

  create_table "reactions", :force => true do |t|
    t.integer  "stream_id"
    t.integer  "reaction_type"
    t.string   "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "social_account_id"
    t.string   "message"
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
    t.binary   "password"
  end

  create_table "statuses", :force => true do |t|
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "likes",      :default => 0
  end

  create_table "streams", :force => true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "streamable_id"
    t.string   "streamable_type"
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

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

ActiveRecord::Schema.define(:version => 20130216195839) do

  create_table "announcements", :force => true do |t|
    t.text     "body"
    t.text     "title"
    t.integer  "author_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "attachments", :force => true do |t|
    t.integer  "puzzle_id"
    t.string   "file"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "authorizations", :force => true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "puzzle_id"
    t.text     "body"
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
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "emails", :force => true do |t|
    t.string   "from_address",     :null => false
    t.string   "reply_to_address"
    t.string   "subject"
    t.text     "to_address"
    t.text     "cc_address"
    t.text     "bcc_address"
    t.text     "content"
    t.datetime "sent_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "puzzles", :force => true do |t|
    t.text     "name"
    t.text     "short_description"
    t.text     "description"
    t.text     "fingerprint"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "created_by"
    t.string   "created_by_url"
    t.date     "released_on"
    t.text     "notice"
    t.boolean  "published",         :default => false
    t.string   "slug"
  end

  create_table "ratings", :force => true do |t|
    t.integer  "user_id"
    t.integer  "puzzle_id"
    t.string   "difficulty"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ratings", ["puzzle_id"], :name => "index_ratings_on_puzzle_id"
  add_index "ratings", ["user_id", "puzzle_id"], :name => "index_ratings_on_user_id_and_puzzle_id", :unique => true
  add_index "ratings", ["user_id"], :name => "index_ratings_on_user_id"

  create_table "submissions", :force => true do |t|
    t.integer  "user_id"
    t.integer  "puzzle_id"
    t.boolean  "correct"
    t.text     "source_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",               :default => false
    t.text     "nickname"
    t.boolean  "draft_access",        :default => false
    t.string   "email"
    t.boolean  "notify_comment_made", :default => false, :null => false
  end

end

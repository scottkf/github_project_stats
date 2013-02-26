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

ActiveRecord::Schema.define(version: 20130226190836) do

  create_table "commits", force: true do |t|
    t.integer  "committer_id"
    t.integer  "repository_id"
    t.integer  "additions",     default: 0
    t.integer  "files_changed", default: 0
    t.integer  "deletions",     default: 0
    t.string   "sha"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "commits", ["committer_id"], name: "index_commits_on_committer_id"
  add_index "commits", ["repository_id"], name: "index_commits_on_repository_id"

  create_table "committers", force: true do |t|
    t.string   "email"
    t.integer  "additions",     default: 0
    t.integer  "deletions",     default: 0
    t.integer  "repository_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "repositories", force: true do |t|
    t.string   "url"
    t.boolean  "complete",   default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end

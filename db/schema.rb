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

ActiveRecord::Schema.define(version: 20150405093614) do

  create_table "organization_connections", force: :cascade do |t|
    t.integer  "organization_a_id", limit: 4, null: false
    t.integer  "organization_b_id", limit: 4, null: false
    t.integer  "num_projects",      limit: 4
    t.integer  "sum_shares",        limit: 4
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "organization_connections", ["organization_a_id"], name: "index_organization_connections_on_organization_a_id", using: :btree
  add_index "organization_connections", ["organization_b_id"], name: "index_organization_connections_on_organization_b_id", using: :btree

  create_table "organizations", force: :cascade do |t|
    t.string   "organisation_name",       limit: 255
    t.string   "organisation_short_name", limit: 255
    t.string   "organization_url",        limit: 255
    t.string   "country",                 limit: 255
    t.string   "street",                  limit: 255
    t.string   "city",                    limit: 255
    t.string   "post_code",               limit: 255
    t.string   "province",                limit: 255
    t.integer  "sum_shares",              limit: 4
    t.integer  "num_projects",            limit: 4
    t.string   "programmes",              limit: 255
    t.integer  "num_programmes",          limit: 4
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  create_table "organizations_projects", id: false, force: :cascade do |t|
    t.integer  "project_id",      limit: 4
    t.integer  "organization_id", limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "projects", force: :cascade do |t|
    t.integer  "reference",             limit: 4
    t.string   "acronym",               limit: 255
    t.string   "programme_pga",         limit: 255
    t.string   "programme_code",        limit: 255
    t.string   "subprogramme",          limit: 255
    t.date     "start_date"
    t.date     "end_date"
    t.string   "project_url",           limit: 255
    t.integer  "total_cost",            limit: 4
    t.integer  "ec_max_contribution",   limit: 4
    t.string   "call",                  limit: 255
    t.string   "funding_scheme",        limit: 255
    t.integer  "organisation_id",       limit: 4
    t.string   "coordinator_country",   limit: 255
    t.string   "participant_countries", limit: 255
    t.string   "countries",             limit: 255
    t.string   "subjects",              limit: 255
    t.integer  "num_countries",         limit: 4
    t.integer  "num_participants",      limit: 4
    t.integer  "num_uniquepart",        limit: 4
    t.integer  "share",                 limit: 4
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

end

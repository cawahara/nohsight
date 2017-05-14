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

ActiveRecord::Schema.define(version: 20170514013703) do

  create_table "event_performers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "event_program_id", null: false
    t.integer  "performer_id",     null: false
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["event_program_id"], name: "event_program_id_idx", using: :btree
    t.index ["performer_id"], name: "performer_id_idx", using: :btree
  end

  create_table "event_programs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "event_id",              null: false
    t.integer  "program_id",            null: false
    t.string   "style",                 null: false
    t.string   "genre",      limit: 45, null: false
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.index ["event_id"], name: "id_idx", using: :btree
    t.index ["program_id"], name: "program_id_idx", using: :btree
  end

  create_table "events", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "place_id",                   null: false
    t.integer  "user_id",                    null: false
    t.string   "title",                      null: false
    t.datetime "start_date",                 null: false
    t.datetime "end_date"
    t.text     "information",  limit: 65535
    t.string   "official_url"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["place_id"], name: "place_id_idx", using: :btree
    t.index ["user_id"], name: "id_idx", using: :btree
  end

  create_table "performers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "full_name",  null: false
    t.string   "last_name",  null: false
    t.string   "first_name", null: false
    t.integer  "style_id",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["style_id"], name: "style_id_idx", using: :btree
  end

  create_table "places", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "title",        limit: 45, null: false
    t.string   "address",                 null: false
    t.string   "official_url",            null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "programs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "title",      null: false
    t.string   "category",   null: false
    t.string   "location"
    t.boolean  "shimai",     null: false
    t.integer  "duration",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "styles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "title",      null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tickets", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "event_id",   null: false
    t.string   "grade",      null: false
    t.integer  "price",      null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "event_id_", using: :btree
    t.index ["event_id"], name: "event_id_idx", using: :btree
    t.index ["event_id"], name: "id_idx", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name",            null: false
    t.string   "email",           null: false
    t.string   "password_digest", null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["email"], name: "email_UNIQUE", unique: true, using: :btree
  end

  add_foreign_key "event_performers", "event_programs", name: "event_program_id"
  add_foreign_key "event_performers", "performers", name: "performer_id"
  add_foreign_key "event_programs", "events", name: "event_id"
  add_foreign_key "event_programs", "programs", name: "program_id"
  add_foreign_key "events", "places", name: "place_id"
  add_foreign_key "events", "users", name: "user_id"
  add_foreign_key "performers", "styles", name: "style_id"
end

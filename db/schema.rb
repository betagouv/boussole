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

ActiveRecord::Schema.define(version: 20170415170944) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "engagements", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "engagements", ["name"], name: "index_engagements_on_name", unique: true, using: :btree

  create_table "exercise_scopes", force: :cascade do |t|
    t.integer  "social_right_id",  null: false
    t.integer  "exercisable_id",   null: false
    t.string   "exercisable_type", null: false
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "exercise_scopes", ["exercisable_type", "exercisable_id"], name: "index_exercise_scopes_on_exercisable_type_and_exercisable_id", using: :btree
  add_index "exercise_scopes", ["social_right_id"], name: "index_exercise_scopes_on_social_right_id", using: :btree

  create_table "features", force: :cascade do |t|
    t.string   "key",                        null: false
    t.boolean  "enabled",    default: false, null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "housings", force: :cascade do |t|
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "duration"
    t.string   "current_status"
    t.integer  "resources",      default: 0
    t.integer  "age"
    t.string   "housing_city"
    t.string   "residence_city"
    t.boolean  "next_status",    default: false
  end

  create_table "last_classes", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "last_classes", ["name"], name: "index_last_classes_on_name", unique: true, using: :btree

  create_table "measures", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.string   "url"
    t.integer  "public_service_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "measures", ["public_service_id"], name: "index_measures_on_public_service_id", using: :btree

  create_table "public_services", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.string   "postal_address"
    t.string   "email"
    t.string   "phone"
    t.string   "url"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "slug"
    t.integer  "response_time_upper_bound"
    t.string   "territorial_competences",   default: [],              array: true
  end

  add_index "public_services", ["response_time_upper_bound"], name: "index_public_services_on_response_time_upper_bound", using: :btree
  add_index "public_services", ["slug"], name: "index_public_services_on_slug", unique: true, using: :btree

  create_table "service_offerings", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "public_service_id",         null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "postal_address"
    t.string   "email"
    t.string   "phone"
    t.string   "url"
    t.string   "slug"
    t.integer  "response_time_upper_bound"
    t.integer  "social_right_id"
  end

  add_index "service_offerings", ["public_service_id", "slug"], name: "index_service_offerings_on_public_service_id_and_slug", unique: true, using: :btree
  add_index "service_offerings", ["public_service_id"], name: "index_service_offerings_on_public_service_id", using: :btree
  add_index "service_offerings", ["response_time_upper_bound"], name: "index_service_offerings_on_response_time_upper_bound", using: :btree
  add_index "service_offerings", ["social_right_id"], name: "index_service_offerings_on_social_right_id", using: :btree

  create_table "social_rights", force: :cascade do |t|
    t.string   "name",       null: false
    t.string   "slug",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "social_rights", ["slug"], name: "index_social_rights_on_slug", unique: true, using: :btree

  create_table "statuses", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "statuses", ["name"], name: "index_statuses_on_name", unique: true, using: :btree

  create_table "target_public_engagements", force: :cascade do |t|
    t.integer  "target_public_id", null: false
    t.integer  "engagement_id",    null: false
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "target_public_engagements", ["engagement_id"], name: "index_target_public_engagements_on_engagement_id", using: :btree
  add_index "target_public_engagements", ["target_public_id"], name: "index_target_public_engagements_on_target_public_id", using: :btree

  create_table "target_public_last_classes", force: :cascade do |t|
    t.integer  "target_public_id", null: false
    t.integer  "last_class_id",    null: false
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "target_public_last_classes", ["last_class_id"], name: "index_target_public_last_classes_on_last_class_id", using: :btree
  add_index "target_public_last_classes", ["target_public_id"], name: "index_target_public_last_classes_on_target_public_id", using: :btree

  create_table "target_public_statuses", force: :cascade do |t|
    t.integer  "target_public_id", null: false
    t.integer  "status_id",        null: false
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "target_public_statuses", ["status_id"], name: "index_target_public_statuses_on_status_id", using: :btree
  add_index "target_public_statuses", ["target_public_id"], name: "index_target_public_statuses_on_target_public_id", using: :btree

  create_table "target_publics", force: :cascade do |t|
    t.integer  "service_offering_id", null: false
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_index "target_publics", ["service_offering_id"], name: "index_target_publics_on_service_offering_id", using: :btree

  create_table "workings", force: :cascade do |t|
    t.string   "awareness"
    t.string   "sector"
    t.boolean  "experience",     default: false
    t.string   "duration"
    t.string   "engagement"
    t.string   "status"
    t.integer  "age"
    t.boolean  "handicap",       default: false
    t.string   "last_class"
    t.string   "city"
    t.boolean  "pole_emploi",    default: false
    t.boolean  "mission_locale", default: false
    t.boolean  "cap_emploi",     default: false
    t.boolean  "apec",           default: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_foreign_key "exercise_scopes", "social_rights"
  add_foreign_key "measures", "public_services"
  add_foreign_key "service_offerings", "public_services"
  add_foreign_key "service_offerings", "social_rights"
  add_foreign_key "target_public_engagements", "engagements"
  add_foreign_key "target_public_engagements", "target_publics"
  add_foreign_key "target_public_last_classes", "last_classes"
  add_foreign_key "target_public_last_classes", "target_publics"
  add_foreign_key "target_public_statuses", "statuses"
  add_foreign_key "target_public_statuses", "target_publics"
  add_foreign_key "target_publics", "service_offerings"
end

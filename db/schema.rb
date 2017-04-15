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

ActiveRecord::Schema.define(version: 20170415182351) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "apecs", force: :cascade do |t|
    t.boolean  "value",      null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "apecs", ["value"], name: "index_apecs_on_value", unique: true, using: :btree

  create_table "cap_emplois", force: :cascade do |t|
    t.boolean  "value",      null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "cap_emplois", ["value"], name: "index_cap_emplois_on_value", unique: true, using: :btree

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

  create_table "experiences", force: :cascade do |t|
    t.boolean  "value",      null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "experiences", ["value"], name: "index_experiences_on_value", unique: true, using: :btree

  create_table "features", force: :cascade do |t|
    t.string   "key",                        null: false
    t.boolean  "enabled",    default: false, null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "housing_durations", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "housing_durations", ["name"], name: "index_housing_durations_on_name", unique: true, using: :btree

  create_table "housing_statuses", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "housing_statuses", ["name"], name: "index_housing_statuses_on_name", unique: true, using: :btree

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

  create_table "mission_locales", force: :cascade do |t|
    t.boolean  "value",      null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "mission_locales", ["value"], name: "index_mission_locales_on_value", unique: true, using: :btree

  create_table "pole_emplois", force: :cascade do |t|
    t.boolean  "value",      null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "pole_emplois", ["value"], name: "index_pole_emplois_on_value", unique: true, using: :btree

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

  create_table "target_public_apecs", force: :cascade do |t|
    t.integer  "target_public_id", null: false
    t.integer  "apec_id",          null: false
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "target_public_apecs", ["apec_id"], name: "index_target_public_apecs_on_apec_id", using: :btree
  add_index "target_public_apecs", ["target_public_id"], name: "index_target_public_apecs_on_target_public_id", using: :btree

  create_table "target_public_cap_emplois", force: :cascade do |t|
    t.integer  "target_public_id", null: false
    t.integer  "cap_emploi_id",    null: false
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "target_public_cap_emplois", ["cap_emploi_id"], name: "index_target_public_cap_emplois_on_cap_emploi_id", using: :btree
  add_index "target_public_cap_emplois", ["target_public_id"], name: "index_target_public_cap_emplois_on_target_public_id", using: :btree

  create_table "target_public_engagements", force: :cascade do |t|
    t.integer  "target_public_id", null: false
    t.integer  "engagement_id",    null: false
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "target_public_engagements", ["engagement_id"], name: "index_target_public_engagements_on_engagement_id", using: :btree
  add_index "target_public_engagements", ["target_public_id"], name: "index_target_public_engagements_on_target_public_id", using: :btree

  create_table "target_public_experiences", force: :cascade do |t|
    t.integer  "target_public_id", null: false
    t.integer  "experience_id",    null: false
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "target_public_experiences", ["experience_id"], name: "index_target_public_experiences_on_experience_id", using: :btree
  add_index "target_public_experiences", ["target_public_id"], name: "index_target_public_experiences_on_target_public_id", using: :btree

  create_table "target_public_housing_durations", force: :cascade do |t|
    t.integer  "target_public_id",    null: false
    t.integer  "housing_duration_id", null: false
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_index "target_public_housing_durations", ["housing_duration_id"], name: "index_target_public_housing_durations_on_housing_duration_id", using: :btree
  add_index "target_public_housing_durations", ["target_public_id"], name: "index_target_public_housing_durations_on_target_public_id", using: :btree

  create_table "target_public_housing_statuses", force: :cascade do |t|
    t.integer  "target_public_id",  null: false
    t.integer  "housing_status_id", null: false
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "target_public_housing_statuses", ["housing_status_id"], name: "index_target_public_housing_statuses_on_housing_status_id", using: :btree
  add_index "target_public_housing_statuses", ["target_public_id"], name: "index_target_public_housing_statuses_on_target_public_id", using: :btree

  create_table "target_public_last_classes", force: :cascade do |t|
    t.integer  "target_public_id", null: false
    t.integer  "last_class_id",    null: false
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "target_public_last_classes", ["last_class_id"], name: "index_target_public_last_classes_on_last_class_id", using: :btree
  add_index "target_public_last_classes", ["target_public_id"], name: "index_target_public_last_classes_on_target_public_id", using: :btree

  create_table "target_public_mission_locales", force: :cascade do |t|
    t.integer  "target_public_id",  null: false
    t.integer  "mission_locale_id", null: false
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "target_public_mission_locales", ["mission_locale_id"], name: "index_target_public_mission_locales_on_mission_locale_id", using: :btree
  add_index "target_public_mission_locales", ["target_public_id"], name: "index_target_public_mission_locales_on_target_public_id", using: :btree

  create_table "target_public_pole_emplois", force: :cascade do |t|
    t.integer  "target_public_id", null: false
    t.integer  "pole_emploi_id",   null: false
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "target_public_pole_emplois", ["pole_emploi_id"], name: "index_target_public_pole_emplois_on_pole_emploi_id", using: :btree
  add_index "target_public_pole_emplois", ["target_public_id"], name: "index_target_public_pole_emplois_on_target_public_id", using: :btree

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
  add_foreign_key "target_public_apecs", "apecs"
  add_foreign_key "target_public_apecs", "target_publics"
  add_foreign_key "target_public_cap_emplois", "cap_emplois"
  add_foreign_key "target_public_cap_emplois", "target_publics"
  add_foreign_key "target_public_engagements", "engagements"
  add_foreign_key "target_public_engagements", "target_publics"
  add_foreign_key "target_public_experiences", "experiences"
  add_foreign_key "target_public_experiences", "target_publics"
  add_foreign_key "target_public_housing_durations", "housing_durations"
  add_foreign_key "target_public_housing_durations", "target_publics"
  add_foreign_key "target_public_housing_statuses", "housing_statuses"
  add_foreign_key "target_public_housing_statuses", "target_publics"
  add_foreign_key "target_public_last_classes", "last_classes"
  add_foreign_key "target_public_last_classes", "target_publics"
  add_foreign_key "target_public_mission_locales", "mission_locales"
  add_foreign_key "target_public_mission_locales", "target_publics"
  add_foreign_key "target_public_pole_emplois", "pole_emplois"
  add_foreign_key "target_public_pole_emplois", "target_publics"
  add_foreign_key "target_publics", "service_offerings"
end

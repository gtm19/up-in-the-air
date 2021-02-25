# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_02_25_212255) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cities", force: :cascade do |t|
    t.string "name"
    t.string "known_for"
    t.string "country"
    t.float "latitude"
    t.float "longitude"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "participant_scores", force: :cascade do |t|
    t.bigint "potential_destination_id", null: false
    t.bigint "trip_participant_id", null: false
    t.float "score"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["potential_destination_id"], name: "index_participant_scores_on_potential_destination_id"
    t.index ["trip_participant_id"], name: "index_participant_scores_on_trip_participant_id"
  end

  create_table "potential_destinations", force: :cascade do |t|
    t.bigint "city_id", null: false
    t.bigint "trip_participant_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["city_id"], name: "index_potential_destinations_on_city_id"
    t.index ["trip_participant_id"], name: "index_potential_destinations_on_trip_participant_id"
  end

  create_table "trip_estimates", force: :cascade do |t|
    t.float "low_cost"
    t.float "high_cost"
    t.integer "flight_mins"
    t.datetime "valid_from"
    t.datetime "valid_until"
    t.bigint "start_city_id"
    t.bigint "destination_city_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["destination_city_id"], name: "index_trip_estimates_on_destination_city_id"
    t.index ["start_city_id"], name: "index_trip_estimates_on_start_city_id"
  end

  create_table "trip_participants", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "trip_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["trip_id"], name: "index_trip_participants_on_trip_id"
    t.index ["user_id"], name: "index_trip_participants_on_user_id"
  end

  create_table "trips", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.bigint "user_id", null: false
    t.date "start_date"
    t.date "end_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "city_id", null: false
    t.index ["city_id"], name: "index_trips_on_city_id"
    t.index ["user_id"], name: "index_trips_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "city_id", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "address_1"
    t.string "address_2"
    t.string "postcode"
    t.index ["city_id"], name: "index_users_on_city_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "participant_scores", "potential_destinations"
  add_foreign_key "participant_scores", "trip_participants"
  add_foreign_key "potential_destinations", "cities"
  add_foreign_key "potential_destinations", "trip_participants"
  add_foreign_key "trip_estimates", "cities", column: "destination_city_id"
  add_foreign_key "trip_estimates", "cities", column: "start_city_id"
  add_foreign_key "trip_participants", "trips"
  add_foreign_key "trip_participants", "users"
  add_foreign_key "trips", "cities"
  add_foreign_key "trips", "users"
  add_foreign_key "users", "cities"
end

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_09_06_135550) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "fixtures", force: :cascade do |t|
    t.string "matchday"
    t.string "hour"
    t.string "day"
    t.string "result"
    t.bigint "home_id", null: false
    t.bigint "away_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "home_name"
    t.string "away_name"
    t.index ["away_id"], name: "index_fixtures_on_away_id"
    t.index ["home_id"], name: "index_fixtures_on_home_id"
  end

  create_table "players", force: :cascade do |t|
    t.string "photo"
    t.string "name"
    t.string "number"
    t.string "position"
    t.string "short_team"
    t.bigint "team_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_id"], name: "index_players_on_team_id"
  end

  create_table "standings", force: :cascade do |t|
    t.string "name_for_table"
    t.string "played"
    t.string "won"
    t.string "draw"
    t.string "lose"
    t.string "goals_for"
    t.string "goals_against"
    t.string "points"
    t.bigint "team_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_id"], name: "index_standings_on_team_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.string "shield"
    t.string "stadium"
    t.string "year"
    t.string "president"
    t.string "site"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "fixtures", "teams", column: "away_id"
  add_foreign_key "fixtures", "teams", column: "home_id"
  add_foreign_key "players", "teams"
  add_foreign_key "standings", "teams"
end

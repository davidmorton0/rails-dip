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

ActiveRecord::Schema.define(version: 2021_09_17_205403) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "games", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "variant_id", null: false
    t.string "current_map"
    t.index ["variant_id"], name: "index_games_on_variant_id"
  end

  create_table "maps", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "orders", force: :cascade do |t|
    t.string "type"
    t.string "unit_type"
    t.boolean "success"
    t.string "failure_reason"
    t.bigint "player_id", null: false
    t.bigint "origin_province_id"
    t.bigint "target_province_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "turn_id", null: false
    t.index ["origin_province_id"], name: "index_orders_on_origin_province_id"
    t.index ["player_id"], name: "index_orders_on_player_id"
    t.index ["target_province_id"], name: "index_orders_on_target_province_id"
    t.index ["turn_id"], name: "index_orders_on_turn_id"
  end

  create_table "players", force: :cascade do |t|
    t.bigint "game_id", null: false
    t.string "country"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "supply"
    t.index ["game_id"], name: "index_players_on_game_id"
  end

  create_table "province_links", force: :cascade do |t|
    t.integer "province_id"
    t.integer "links_to"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "provinces", force: :cascade do |t|
    t.string "name"
    t.string "abbreviation"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "supply_center"
    t.bigint "map_id", null: false
    t.string "province_type"
    t.integer "x_pos"
    t.integer "y_pos"
    t.index ["map_id"], name: "index_provinces_on_map_id"
  end

  create_table "turns", force: :cascade do |t|
    t.integer "year"
    t.string "season"
    t.bigint "game_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["game_id"], name: "index_turns_on_game_id"
  end

  create_table "units", force: :cascade do |t|
    t.bigint "province_id"
    t.string "unit_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "player_id"
    t.index ["player_id"], name: "index_units_on_player_id"
    t.index ["province_id"], name: "index_units_on_province_id"
  end

  create_table "variants", force: :cascade do |t|
    t.string "name"
    t.string "countries", default: [], array: true
    t.string "string", default: [], array: true
    t.integer "starting_year"
    t.string "starting_season"
    t.bigint "map_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["map_id"], name: "index_variants_on_map_id"
  end

  add_foreign_key "games", "variants"
  add_foreign_key "orders", "players"
  add_foreign_key "orders", "provinces", column: "origin_province_id"
  add_foreign_key "orders", "provinces", column: "target_province_id"
  add_foreign_key "orders", "turns"
  add_foreign_key "players", "games"
  add_foreign_key "provinces", "maps"
  add_foreign_key "turns", "games"
  add_foreign_key "variants", "maps"
end

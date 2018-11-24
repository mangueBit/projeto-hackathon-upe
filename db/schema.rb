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

ActiveRecord::Schema.define(version: 2018_11_24_200056) do

  create_table "leituras", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "sensor_id"
    t.string "tipo"
    t.string "bateria_amount"
    t.integer "transporte_id"
  end

  create_table "sensor_configs", force: :cascade do |t|
    t.string "configs"
    t.string "sensor_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sensors", force: :cascade do |t|
    t.string "local"
    t.string "tipo"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "code"
  end

  create_table "transportes", force: :cascade do |t|
    t.string "used_time"
    t.string "history"
    t.string "ratio"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "sensor_id"
    t.string "code"
    t.integer "bateria"
  end

end

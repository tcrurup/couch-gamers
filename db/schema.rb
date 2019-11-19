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

ActiveRecord::Schema.define(version: 2019_10_31_141424) do

  create_table "developers", force: :cascade do |t|
    t.string "name"
    t.integer "user_id"
  end

  create_table "games", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.integer "release_year"
    t.integer "developer_id"
  end

  create_table "user_developers", force: :cascade do |t|
    t.integer "user_id"
    t.integer "developer_id"
  end

  create_table "user_games", force: :cascade do |t|
    t.integer "user_id"
    t.integer "game_id"
    t.boolean "favorited"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "password_digest"
    t.integer "developer_id"
    t.string "uid"
    t.string "image"
    t.boolean "set_pw", default: true
  end

end

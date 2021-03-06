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

ActiveRecord::Schema.define(version: 2020_04_15_035641) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "feeds", force: :cascade do |t|
    t.string "url", null: false
    t.string "name"
    t.string "website_url"
    t.datetime "last_checked"
    t.integer "status", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "last_successful_check"
    t.datetime "last_failed_check"
    t.boolean "sanitise", default: false
    t.index ["status"], name: "index_feeds_on_status"
  end

  create_table "items", force: :cascade do |t|
    t.integer "feed_id"
    t.string "unique_identifier", null: false
    t.string "title"
    t.text "content_html"
    t.string "url"
    t.string "external_url"
    t.text "summary"
    t.datetime "date_published"
    t.boolean "starred", default: false
    t.boolean "read", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end

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

ActiveRecord::Schema.define(version: 2022_03_11_230114) do

  create_table "articles", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "status"
  end

  create_table "bugs", force: :cascade do |t|
    t.string "title"
    t.string "number"
    t.integer "importance"
    t.text "notes"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "status"
    t.string "product"
    t.string "assigned_to"
    t.string "creator"
    t.string "severity"
    t.string "qa_contact"
    t.string "version"
    t.string "whiteboard"
    t.string "target_release"
    t.text "summary"
    t.string "fixed_in"
    t.string "release_notes"
    t.string "component"
    t.string "keywords"
    t.string "target_milestone"
    t.string "last_change"
    t.text "cc"
    t.text "cc_detail"
    t.string "url"
  end

  create_table "cases", force: :cascade do |t|
    t.string "version"
    t.string "title"
    t.string "number"
    t.integer "comments"
    t.integer "importance"
    t.text "notes"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "status"
    t.boolean "fts"
    t.boolean "collaboration"
    t.boolean "rme"
    t.boolean "drd"
    t.integer "views"
    t.datetime "watcher", precision: 6
    t.string "customer"
    t.integer "account_number"
    t.string "owner_first"
    t.string "owner_last"
    t.string "sbr"
    t.string "product"
    t.text "issue"
    t.string "summary"
    t.string "bug_number"
    t.text "bug_summary"
    t.string "customer_contact"
    t.string "customer_name"
    t.string "case_owner"
    t.string "link"
    t.string "url"
    t.string "region"
    t.boolean "handover"
    t.boolean "closed"
    t.boolean "escalated"
    t.string "ownerIRC"
    t.string "state"
    t.string "strategic"
    t.string "tags"
    t.text "description"
    t.string "breaches"
    t.string "case_tag"
  end

  create_table "commands", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "body"
    t.string "status"
  end

  create_table "comments", force: :cascade do |t|
    t.string "commenter"
    t.text "body"
    t.integer "commentable_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "status"
    t.string "commentable_type"
    t.text "url"
    t.index ["commentable_id"], name: "index_comments_on_commentable_id"
  end

  create_table "engineer_tags", force: :cascade do |t|
    t.integer "engineer_taggable_id"
    t.string "engineer_taggable_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "engineer_id"
    t.string "status"
  end

  create_table "engineers", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "position"
    t.string "irc"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "status"
  end

  create_table "network_tags", force: :cascade do |t|
    t.boolean "ipv4"
    t.boolean "ipv6"
    t.boolean "bond"
    t.boolean "vlan"
    t.boolean "bridge"
    t.boolean "proxy"
    t.boolean "firewall"
    t.string "network_taggable_type"
    t.integer "network_taggable_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "provision_tags", force: :cascade do |t|
    t.string "version"
    t.integer "provision_taggable_id"
    t.string "provision_taggable_type"
    t.boolean "contentview"
    t.boolean "capsule"
    t.boolean "http"
    t.boolean "ui"
    t.boolean "pxe"
    t.boolean "bootstrap"
    t.boolean "kickstart"
    t.boolean "discover"
    t.boolean "image"
    t.boolean "compute"
    t.text "notes"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "bootdisk"
    t.boolean "ipxe"
  end

  create_table "satellite_tags", force: :cascade do |t|
    t.string "version"
    t.boolean "pulp"
    t.string "satellite_taggable_type"
    t.integer "satellite_taggable_id"
    t.boolean "postgres"
    t.boolean "foreman_proxy"
    t.boolean "installer"
    t.boolean "publish"
    t.boolean "promote"
    t.boolean "contentview"
    t.boolean "capsule"
    t.boolean "sync"
    t.boolean "repository"
    t.boolean "metadata"
    t.boolean "mongo"
    t.boolean "redis"
    t.boolean "puma"
    t.boolean "http"
    t.boolean "reports"
    t.boolean "ui"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["satellite_taggable_type", "satellite_taggable_id"], name: "index_satellite_tags_on_satellite_taggable"
  end

  create_table "solutions", force: :cascade do |t|
    t.string "title"
    t.string "number"
    t.integer "importance"
    t.text "notes"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "status"
    t.text "abstract"
    t.string "author"
    t.string "boostProduct"
    t.string "inferred_tag"
    t.string "state"
    t.string "url"
    t.string "product"
    t.string "tag"
    t.string "created"
    t.string "solution_tag"
  end

  create_table "tag_groups", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "tag_items", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "tag_group_id"
    t.index ["tag_group_id"], name: "index_tag_items_on_tag_group_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "tag_taggable_id"
    t.string "tag_taggable_type"
    t.integer "tag_item_id"
    t.integer "tag_group_id"
    t.index ["tag_group_id"], name: "index_tags_on_tag_group_id"
    t.index ["tag_item_id"], name: "index_tags_on_tag_item_id"
  end

end

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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120909104903) do

  create_table "entities", :force => true do |t|
    t.string   "username"
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "password_digest"
    t.string   "remember_token"
  end

  add_index "entities", ["email"], :name => "index_entities_on_email", :unique => true
  add_index "entities", ["remember_token"], :name => "index_entities_on_remember_token"
  add_index "entities", ["username"], :name => "index_entities_on_username", :unique => true

  create_table "volunteers", :force => true do |t|
    t.string   "username"
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "password_digest"
    t.string   "remember_token"
  end

  add_index "volunteers", ["email"], :name => "index_volunteers_on_email", :unique => true
  add_index "volunteers", ["remember_token"], :name => "index_volunteers_on_remember_token"
  add_index "volunteers", ["username"], :name => "index_volunteers_on_username", :unique => true

end

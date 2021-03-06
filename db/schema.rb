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

ActiveRecord::Schema.define(:version => 20130222080020) do

  create_table "areas", :force => true do |t|
    t.string  "name", :limit => 50
    t.decimal "area"
    t.spatial "geom", :limit => {:srid=>0, :type=>"multi_polygon", :has_m=>true, :has_z=>true}
  end

  add_index "areas", ["geom"], :name => "areas_geom_idx", :spatial => true

  create_table "districts", :force => true do |t|
    t.string  "name", :limit => 100
    t.decimal "area"
    t.spatial "geom", :limit => {:srid=>0, :type=>"multi_polygon", :has_m=>true, :has_z=>true}
  end

  add_index "districts", ["geom"], :name => "districts_geom_idx", :spatial => true

  create_table "events", :force => true do |t|
    t.string   "type_code"
    t.datetime "created_at",                                        :null => false
    t.datetime "updated_at",                                        :null => false
    t.spatial  "lonlat",      :limit => {:srid=>0, :type=>"point"}
    t.string   "token"
    t.integer  "district_id"
    t.integer  "area_id"
  end

  add_index "events", ["area_id"], :name => "index_events_on_area_id"
  add_index "events", ["district_id"], :name => "index_events_on_district_id"
  add_index "events", ["token"], :name => "index_events_on_token"

end

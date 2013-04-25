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

ActiveRecord::Schema.define(:version => 20130104221429) do

  create_table "alerts", :force => true do |t|
    t.string   "display_name"
    t.string   "alert_type"
    t.string   "who_to_alert"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "facilities", :force => true do |t|
    t.string   "display_name"
    t.string   "city"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "lab_methods", :force => true do |t|
    t.string   "display_name"
    t.boolean  "temperature"
    t.boolean  "solids"
    t.boolean  "moisture"
    t.boolean  "bulk_density"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "products", :force => true do |t|
    t.string   "display_name"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "qualities", :force => true do |t|
    t.string   "julian_date"
    t.datetime "time"
    t.integer  "tank"
    t.decimal  "temperature"
    t.integer  "lab_method_id"
    t.integer  "product_id"
    t.datetime "updated_at"
    t.datetime "created_at"
    t.datetime "date"
    t.integer  "user_id"
    t.string   "lot"
    t.decimal  "viscosity"
    t.decimal  "solids"
    t.decimal  "moisture"
    t.decimal  "bulk_density"
    t.decimal  "color_l"
    t.decimal  "color_a"
    t.decimal  "color_b"
    t.string   "starch_lot"
    t.string   "last_disposition_state"
    t.boolean  "coa_printed"
    t.string   "last_bulk_density_state"
    t.decimal  "last_bulk_density_value"
    t.decimal  "last_viscosity_value"
    t.string   "last_viscosity_state"
    t.string   "last_moisture_state"
    t.decimal  "last_moisture_value"
    t.decimal  "last_color_l_value"
    t.string   "last_color_l_state"
    t.decimal  "last_corrected_viscosity_value"
    t.string   "skid"
  end

  create_table "quality_histories", :force => true do |t|
    t.integer  "quality_id"
    t.integer  "user_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "action_type"
    t.string   "skid"
  end

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "facility_id"
    t.string   "options"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active"
    t.string   "encrypted_password"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count"
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.boolean  "administrator"
    t.boolean  "technician"
    t.boolean  "sales"
    t.boolean  "quality"
    t.boolean  "customer"
    t.string   "email"
    t.boolean  "labSupervisor"
  end

end

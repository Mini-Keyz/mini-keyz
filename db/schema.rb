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

ActiveRecord::Schema.define(version: 20_210_430_073_125) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'simulations', force: :cascade do |t|
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.string 'house_city'
    t.integer 'house_price_bought'
    t.integer 'house_first_works'
    t.integer 'house_annual_charges'
    t.integer 'house_property_tax'
    t.integer 'house_rent_per_month'
    t.boolean 'house_delegated_maintenance'
    t.integer 'credit_amount'
    t.integer 'credit_duration'
    t.string 'fiscal_status'
    t.integer 'fiscal_status_duration'
    t.string 'fiscal_regimen'
    t.integer 'fiscal_revenues_p1'
    t.integer 'fiscal_revenues_p2'
    t.float 'fiscal_nb_parts'
    t.bigint 'user_id'
    t.index ['user_id'], name: 'index_simulations_on_user_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
  end

  add_foreign_key 'simulations', 'users'
end

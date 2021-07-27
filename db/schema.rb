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

ActiveRecord::Schema.define(version: 2021_07_23_084254) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "simulations", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "house_city"
    t.integer "house_price_bought_amount"
    t.integer "house_first_works_amount"
    t.integer "house_total_charges_amount_per_year"
    t.integer "house_property_tax_amount_per_year"
    t.integer "house_rent_amount_per_month"
    t.boolean "house_delegated_maintenance"
    t.integer "credit_loan_amount"
    t.integer "credit_loan_duration"
    t.string "fiscal_status"
    t.integer "fiscal_status_duration"
    t.string "fiscal_regimen"
    t.integer "fiscal_revenues_p1"
    t.integer "fiscal_revenues_p2"
    t.bigint "user_id"
    t.float "house_property_management_cost_percentage"
    t.float "house_notarial_fees_percentage"
    t.float "credit_loan_interest_percentage_per_year"
    t.float "credit_loan_insurance_percentage_per_year"
    t.float "house_tenant_charges_percentage"
    t.float "house_insurance_pno_amount_per_year"
    t.float "house_insurance_gli_percentage"
    t.integer "fiscal_nb_dependent_children"
    t.integer "fiscal_nb_alternate_custody_children"
    t.index ["user_id"], name: "index_simulations_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "first_name"
    t.string "last_name"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "simulations", "users"
end

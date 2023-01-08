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

ActiveRecord::Schema.define(version: 2019_09_05_094402) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "announcements", force: :cascade do |t|
    t.datetime "published_at"
    t.string "announcement_type"
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "api_params", force: :cascade do |t|
    t.text "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "billings", force: :cascade do |t|
    t.string "name"
    t.decimal "latitude"
    t.decimal "longitude"
    t.datetime "from"
    t.datetime "to"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_billings_on_user_id"
  end

  create_table "calc_registers", force: :cascade do |t|
    t.string "status"
    t.date "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "subject"
    t.text "calculation_record"
    t.integer "surveyor_id"
    t.bigint "project_id"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_calc_registers_on_deleted_at"
    t.index ["project_id"], name: "index_calc_registers_on_project_id"
  end

  create_table "clients", force: :cascade do |t|
    t.string "name"
    t.string "client_code"
    t.string "abn"
    t.string "unique_id"
    t.string "accounts_contact_email"
    t.string "address"
    t.bigint "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["company_id"], name: "index_clients_on_company_id"
    t.index ["deleted_at"], name: "index_clients_on_deleted_at"
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "uuid", default: -> { "uuid_generate_v4()" }, null: false
  end

  create_table "correspondences", force: :cascade do |t|
    t.string "file_id"
    t.string "file_type"
    t.date "date"
    t.text "description"
    t.string "subject"
    t.string "to"
    t.string "from"
    t.string "in_or_out"
    t.text "attachment_list", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "project_id"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_correspondences_on_deleted_at"
    t.index ["project_id"], name: "index_correspondences_on_project_id"
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "dps", force: :cascade do |t|
    t.string "file_id"
    t.string "file_type"
    t.date "date"
    t.text "description"
    t.string "subject"
    t.string "to"
    t.string "from"
    t.string "in_or_out"
    t.text "attachment_list", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "field_notes", force: :cascade do |t|
    t.string "file_id"
    t.string "file_type"
    t.string "day_job"
    t.datetime "date"
    t.text "description"
    t.text "summary"
    t.text "detail"
    t.boolean "additional_processing"
    t.string "additional_1"
    t.string "additional_2"
    t.string "additional_3"
    t.string "additional_4"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "project_id"
    t.string "day_job_file"
    t.integer "surveyor_id"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_field_notes_on_deleted_at"
    t.index ["project_id"], name: "index_field_notes_on_project_id"
  end

  create_table "file_attachments", force: :cascade do |t|
    t.text "data", null: false
    t.string "filename"
    t.string "mime_type"
    t.string "extension"
    t.bigint "field_note_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "attachable_type"
    t.bigint "attachable_id"
    t.index ["attachable_type", "attachable_id"], name: "index_file_attachments_on_attachable_type_and_attachable_id"
    t.index ["field_note_id"], name: "index_file_attachments_on_field_note_id"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_type", "sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_type_and_sluggable_id"
  end

  create_table "given_data", force: :cascade do |t|
    t.string "file_id"
    t.string "file_type"
    t.date "date"
    t.text "description"
    t.string "subject"
    t.string "to"
    t.string "from"
    t.string "in_or_out"
    t.text "attachment_list", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "project_id"
    t.datetime "deleted_at"
    t.boolean "status", default: true
    t.index ["deleted_at"], name: "index_given_data_on_deleted_at"
    t.index ["project_id"], name: "index_given_data_on_project_id"
  end

  create_table "instruments", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "company_id"
    t.string "two_digit_id"
    t.string "instrument_type"
    t.string "serial_number"
    t.string "firmware_version"
    t.date "service_due_date"
    t.datetime "deleted_at"
    t.index ["company_id"], name: "index_instruments_on_company_id"
    t.index ["deleted_at"], name: "index_instruments_on_deleted_at"
  end

  create_table "invitations", force: :cascade do |t|
    t.string "email"
    t.bigint "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "uuid", default: -> { "uuid_generate_v4()" }, null: false
    t.index ["company_id"], name: "index_invitations_on_company_id"
  end

  create_table "items", force: :cascade do |t|
    t.string "item_name"
    t.text "details"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "project_id"
    t.index ["project_id"], name: "index_items_on_project_id"
  end

  create_table "notes", force: :cascade do |t|
    t.string "item"
    t.text "instructions"
    t.integer "index"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "project_id"
    t.index ["project_id"], name: "index_notes_on_project_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.bigint "recipient_id"
    t.bigint "actor_id"
    t.datetime "read_at"
    t.string "action"
    t.bigint "notifiable_id"
    t.string "notifiable_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "project_timings", force: :cascade do |t|
    t.bigint "project_id"
    t.bigint "timing_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_project_timings_on_project_id"
    t.index ["timing_id"], name: "index_project_timings_on_timing_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "project_number"
    t.string "name"
    t.string "location"
    t.string "project_client_code"
    t.string "project_authority"
    t.string "project_authority_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "instrument_id"
    t.bigint "survey_controller_id"
    t.bigint "company_id"
    t.bigint "client_id"
    t.string "client_line_1"
    t.string "client_line_2"
    t.string "client_line_3"
    t.string "job_line_1"
    t.string "job_line_2"
    t.string "job_line_3"
    t.integer "text_angle"
    t.boolean "status", default: true
    t.float "latitude"
    t.float "longitude"
    t.datetime "field_notes_last_requested_at"
    t.datetime "to_fields_last_requested_at"
    t.datetime "deleted_at"
    t.string "client_short_name"
    t.index ["client_id"], name: "index_projects_on_client_id"
    t.index ["company_id"], name: "index_projects_on_company_id"
    t.index ["deleted_at"], name: "index_projects_on_deleted_at"
    t.index ["instrument_id"], name: "index_projects_on_instrument_id"
    t.index ["survey_controller_id"], name: "index_projects_on_survey_controller_id"
  end

  create_table "services", force: :cascade do |t|
    t.bigint "user_id"
    t.string "provider"
    t.string "uid"
    t.string "access_token"
    t.string "access_token_secret"
    t.string "refresh_token"
    t.datetime "expires_at"
    t.text "auth"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_services_on_user_id"
  end

  create_table "stylesheets", force: :cascade do |t|
    t.string "unique_id"
    t.string "stylesheet_type"
    t.string "path"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "label"
    t.string "output_extension"
    t.boolean "create_slx", default: false
    t.bigint "company_id"
    t.bigint "user_id"
    t.datetime "deleted_at"
    t.index ["company_id"], name: "index_stylesheets_on_company_id"
    t.index ["deleted_at"], name: "index_stylesheets_on_deleted_at"
    t.index ["user_id"], name: "index_stylesheets_on_user_id"
  end

  create_table "survey_controllers", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "company_id"
    t.string "two_digit_id"
    t.string "controller_type"
    t.string "serial_number"
    t.string "software_version"
    t.string "controller_login"
    t.datetime "deleted_at"
    t.index ["company_id"], name: "index_survey_controllers_on_company_id"
    t.index ["deleted_at"], name: "index_survey_controllers_on_deleted_at"
  end

  create_table "survey_type_default_stylesheets", force: :cascade do |t|
    t.bigint "survey_type_id"
    t.bigint "stylesheet_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["stylesheet_id"], name: "index_survey_type_default_stylesheets_on_stylesheet_id"
    t.index ["survey_type_id"], name: "index_survey_type_default_stylesheets_on_survey_type_id"
  end

  create_table "survey_type_optional_stylesheets", force: :cascade do |t|
    t.bigint "survey_type_id"
    t.bigint "stylesheet_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["stylesheet_id"], name: "index_survey_type_optional_stylesheets_on_stylesheet_id"
    t.index ["survey_type_id"], name: "index_survey_type_optional_stylesheets_on_survey_type_id"
  end

  create_table "survey_types", force: :cascade do |t|
    t.string "two_digit_id"
    t.string "description"
    t.bigint "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["company_id"], name: "index_survey_types_on_company_id"
    t.index ["deleted_at"], name: "index_survey_types_on_deleted_at"
  end

  create_table "surveyors", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "company_id"
    t.string "two_digit_id"
    t.string "initials"
    t.string "login"
    t.string "password"
    t.index ["company_id"], name: "index_surveyors_on_company_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.datetime "completed_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "due_date"
    t.text "notes"
    t.integer "surveyor_id"
    t.text "description"
    t.bigint "project_id"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_tasks_on_deleted_at"
    t.index ["project_id"], name: "index_tasks_on_project_id"
  end

  create_table "timings", force: :cascade do |t|
    t.datetime "entry_time"
    t.datetime "exit_time"
    t.string "duration"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "project_id"
    t.integer "surveyor_id"
    t.text "description"
    t.float "travel_duration", default: 0.0
    t.float "office_duration", default: 0.0
    t.float "field_duration", default: 0.0
    t.float "total_duration", default: 0.0
    t.date "date"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_timings_on_deleted_at"
    t.index ["project_id"], name: "index_timings_on_project_id"
  end

  create_table "to_fields", force: :cascade do |t|
    t.bigint "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "record_id"
    t.string "extension"
    t.string "status"
    t.text "notes"
    t.integer "surveyor_id"
    t.datetime "date"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_to_fields_on_deleted_at"
    t.index ["project_id"], name: "index_to_fields_on_project_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "first_name"
    t.string "last_name"
    t.datetime "announcements_last_read_at"
    t.boolean "admin", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "address"
    t.string "abn"
    t.string "accounts_contact_name"
    t.string "accounts_contact_number"
    t.bigint "company_id"
    t.string "authentication_token", limit: 30
    t.string "initials"
    t.string "two_digit_id"
    t.datetime "deleted_at"
    t.boolean "company_admin", default: false
    t.index ["authentication_token"], name: "index_users_on_authentication_token", unique: true
    t.index ["company_id"], name: "index_users_on_company_id"
    t.index ["deleted_at"], name: "index_users_on_deleted_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "billings", "users"
  add_foreign_key "calc_registers", "projects"
  add_foreign_key "clients", "users", column: "company_id"
  add_foreign_key "correspondences", "projects"
  add_foreign_key "field_notes", "projects"
  add_foreign_key "file_attachments", "field_notes"
  add_foreign_key "given_data", "projects"
  add_foreign_key "instruments", "users", column: "company_id"
  add_foreign_key "invitations", "companies"
  add_foreign_key "items", "projects"
  add_foreign_key "notes", "projects"
  add_foreign_key "project_timings", "projects"
  add_foreign_key "project_timings", "timings"
  add_foreign_key "projects", "clients"
  add_foreign_key "projects", "instruments"
  add_foreign_key "projects", "survey_controllers"
  add_foreign_key "projects", "users", column: "company_id"
  add_foreign_key "services", "users"
  add_foreign_key "stylesheets", "companies"
  add_foreign_key "stylesheets", "users"
  add_foreign_key "survey_controllers", "users", column: "company_id"
  add_foreign_key "survey_type_default_stylesheets", "stylesheets"
  add_foreign_key "survey_type_default_stylesheets", "survey_types"
  add_foreign_key "survey_type_optional_stylesheets", "stylesheets"
  add_foreign_key "survey_type_optional_stylesheets", "survey_types"
  add_foreign_key "survey_types", "users", column: "company_id"
  add_foreign_key "surveyors", "users", column: "company_id"
  add_foreign_key "tasks", "projects"
  add_foreign_key "timings", "projects"
  add_foreign_key "to_fields", "projects"
  add_foreign_key "users", "companies"
end

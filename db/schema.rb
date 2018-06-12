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

ActiveRecord::Schema.define(version: 20180612222553) do

  create_table "blog_posts", force: :cascade do |t|
    t.string   "title"
    t.string   "image"
    t.string   "tagline"
    t.text     "content"
    t.string   "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["title"], name: "index_blog_posts_on_title"
  end

  create_table "bookmarks", force: :cascade do |t|
    t.integer  "student_id"
    t.integer  "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_bookmarks_on_course_id"
    t.index ["student_id"], name: "index_bookmarks_on_student_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.string   "image"
    t.string   "slug"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "comments", force: :cascade do |t|
    t.integer  "instructor_id"
    t.integer  "student_id"
    t.integer  "video_id"
    t.text     "content"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["instructor_id"], name: "index_comments_on_instructor_id"
    t.index ["student_id"], name: "index_comments_on_student_id"
    t.index ["video_id"], name: "index_comments_on_video_id"
  end

  create_table "courses", force: :cascade do |t|
    t.integer  "instructor_id"
    t.integer  "category_id"
    t.integer  "subcategory_id"
    t.string   "title"
    t.text     "image_data"
    t.string   "tagline"
    t.string   "language"
    t.text     "requirements"
    t.text     "description"
    t.text     "highlights"
    t.text     "target"
    t.boolean  "paid",                                   default: false
    t.decimal  "price",          precision: 9, scale: 2
    t.string   "currency"
    t.integer  "refund_policy",                          default: 0
    t.string   "slug"
    t.datetime "created_at",                                             null: false
    t.datetime "updated_at",                                             null: false
    t.index ["category_id"], name: "index_courses_on_category_id"
    t.index ["currency"], name: "index_courses_on_currency"
    t.index ["instructor_id"], name: "index_courses_on_instructor_id"
    t.index ["price"], name: "index_courses_on_price"
    t.index ["subcategory_id"], name: "index_courses_on_subcategory_id"
    t.index ["tagline"], name: "index_courses_on_tagline"
    t.index ["title"], name: "index_courses_on_title"
  end

  create_table "instructors", force: :cascade do |t|
    t.string   "username",               default: "",   null: false
    t.string   "slug",                   default: "",   null: false
    t.string   "email",                  default: "",   null: false
    t.string   "encrypted_password",     default: "",   null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,    null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,    null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.boolean  "purchase_email",         default: true
    t.boolean  "refund_email",           default: true
    t.boolean  "subscription_email",     default: true
    t.boolean  "review_email",           default: true
    t.boolean  "comment_email",          default: true
    t.boolean  "message_email",          default: true
    t.string   "plan_id",                default: ""
    t.string   "product_id",             default: ""
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.index ["confirmation_token"], name: "index_instructors_on_confirmation_token", unique: true
    t.index ["email"], name: "index_instructors_on_email", unique: true
    t.index ["plan_id"], name: "index_instructors_on_plan_id", unique: true
    t.index ["reset_password_token"], name: "index_instructors_on_reset_password_token", unique: true
    t.index ["slug"], name: "index_instructors_on_slug", unique: true
    t.index ["unlock_token"], name: "index_instructors_on_unlock_token", unique: true
    t.index ["username"], name: "index_instructors_on_username", unique: true
  end

  create_table "merchants", force: :cascade do |t|
    t.integer  "instructor_id"
    t.string   "stripe_publishable_key"
    t.string   "stripe_secret_key"
    t.string   "stripe_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "currency"
    t.string   "country"
    t.integer  "month"
    t.integer  "day"
    t.integer  "year"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["instructor_id"], name: "index_merchants_on_instructor_id"
  end

  create_table "messages", force: :cascade do |t|
    t.integer  "instructor_id"
    t.integer  "student_id"
    t.text     "content"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["instructor_id"], name: "index_messages_on_instructor_id"
    t.index ["student_id"], name: "index_messages_on_student_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.integer  "instructor_id"
    t.integer  "student_id"
    t.integer  "review_id"
    t.integer  "comment_id"
    t.integer  "purchase_id"
    t.integer  "subscription_id"
    t.string   "notice_type"
    t.boolean  "read",            default: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.index ["comment_id"], name: "index_notifications_on_comment_id"
    t.index ["instructor_id"], name: "index_notifications_on_instructor_id"
    t.index ["notice_type"], name: "index_notifications_on_notice_type"
    t.index ["purchase_id"], name: "index_notifications_on_purchase_id"
    t.index ["read"], name: "index_notifications_on_read"
    t.index ["review_id"], name: "index_notifications_on_review_id"
    t.index ["student_id"], name: "index_notifications_on_student_id"
    t.index ["subscription_id"], name: "index_notifications_on_subscription_id"
  end

  create_table "posts", force: :cascade do |t|
    t.integer  "instructor_id"
    t.string   "title"
    t.text     "image_data"
    t.text     "content"
    t.string   "slug"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["instructor_id"], name: "index_posts_on_instructor_id"
    t.index ["title"], name: "index_posts_on_title"
  end

  create_table "profiles", force: :cascade do |t|
    t.integer  "instructor_id"
    t.integer  "student_id"
    t.string   "first_name",     default: ""
    t.string   "last_name",      default: ""
    t.text     "image_data"
    t.string   "city",           default: ""
    t.string   "state",          default: ""
    t.string   "country",        default: ""
    t.string   "website",        default: ""
    t.string   "twitter_handle", default: ""
    t.string   "twitter_url",    default: ""
    t.string   "youtube_handle", default: ""
    t.string   "youtube_url",    default: ""
    t.text     "biography",      default: ""
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.index ["first_name"], name: "index_profiles_on_first_name"
    t.index ["instructor_id"], name: "index_profiles_on_instructor_id"
    t.index ["last_name"], name: "index_profiles_on_last_name"
    t.index ["student_id"], name: "index_profiles_on_student_id"
  end

  create_table "purchases", force: :cascade do |t|
    t.integer  "course_id"
    t.integer  "instructor_id"
    t.integer  "student_id"
    t.string   "stripe_charge_id"
    t.boolean  "use_your_card",    default: false
    t.integer  "price"
    t.string   "currency"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.index ["course_id"], name: "index_purchases_on_course_id"
    t.index ["currency"], name: "index_purchases_on_currency"
    t.index ["instructor_id"], name: "index_purchases_on_instructor_id"
    t.index ["price"], name: "index_purchases_on_price"
    t.index ["stripe_charge_id"], name: "index_purchases_on_stripe_charge_id"
    t.index ["student_id"], name: "index_purchases_on_student_id"
  end

  create_table "replies", force: :cascade do |t|
    t.integer  "instructor_id"
    t.integer  "student_id"
    t.text     "content"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["instructor_id"], name: "index_replies_on_instructor_id"
    t.index ["student_id"], name: "index_replies_on_student_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.integer  "instructor_id"
    t.integer  "student_id"
    t.integer  "course_id"
    t.integer  "rating",        default: 3
    t.text     "content"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.index ["course_id"], name: "index_reviews_on_course_id"
    t.index ["instructor_id"], name: "index_reviews_on_instructor_id"
    t.index ["rating"], name: "index_reviews_on_rating"
    t.index ["student_id"], name: "index_reviews_on_student_id"
  end

  create_table "students", force: :cascade do |t|
    t.string   "username",               default: "",   null: false
    t.string   "slug",                   default: "",   null: false
    t.string   "email",                  default: "",   null: false
    t.string   "encrypted_password",     default: "",   null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,    null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,    null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.boolean  "course_email",           default: true
    t.boolean  "post_email",             default: true
    t.boolean  "message_email",          default: true
    t.string   "customer_id",            default: "f"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.index ["confirmation_token"], name: "index_students_on_confirmation_token", unique: true
    t.index ["customer_id"], name: "index_students_on_customer_id", unique: true
    t.index ["email"], name: "index_students_on_email", unique: true
    t.index ["reset_password_token"], name: "index_students_on_reset_password_token", unique: true
    t.index ["slug"], name: "index_students_on_slug", unique: true
    t.index ["unlock_token"], name: "index_students_on_unlock_token", unique: true
    t.index ["username"], name: "index_students_on_username", unique: true
  end

  create_table "subcategories", force: :cascade do |t|
    t.integer  "category_id"
    t.string   "title"
    t.text     "description"
    t.string   "image"
    t.string   "slug"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["category_id"], name: "index_subcategories_on_category_id"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.integer  "instructor_id"
    t.integer  "student_id"
    t.string   "stripe_subscription_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["instructor_id"], name: "index_subscriptions_on_instructor_id"
    t.index ["stripe_subscription_id"], name: "index_subscriptions_on_stripe_subscription_id"
    t.index ["student_id"], name: "index_subscriptions_on_student_id"
  end

  create_table "tracks", force: :cascade do |t|
    t.integer  "instructor_id"
    t.integer  "course_id"
    t.string   "title"
    t.string   "slug"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["course_id"], name: "index_tracks_on_course_id"
    t.index ["instructor_id"], name: "index_tracks_on_instructor_id"
    t.index ["title"], name: "index_tracks_on_title"
  end

  create_table "videos", force: :cascade do |t|
    t.integer  "instructor_id"
    t.integer  "track_id"
    t.string   "title"
    t.text     "video_data"
    t.text     "description"
    t.string   "slug"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["instructor_id"], name: "index_videos_on_instructor_id"
    t.index ["title"], name: "index_videos_on_title"
    t.index ["track_id"], name: "index_videos_on_track_id"
  end

end

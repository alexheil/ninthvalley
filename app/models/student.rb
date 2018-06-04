class Student < ApplicationRecord
  extend FriendlyId
  friendly_id :username, use: :slugged

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :timeoutable
   #:omniauthable, :confirmable, :lockable

  attr_accessor :login
  attr_accessor :cardholder

  validates :username, presence: true, uniqueness: true, length: { maximum: 50 }, format: { with: /\A[a-zA-Z0-9]+\Z/i }
  validate :validate_username

  has_one :profile, dependent: :destroy

  has_many :reviews, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :bookmarks
  has_many :courses, through: :bookmarks

  has_many :purchases
  has_many :courses, through: :purchases
  belongs_to :course
  belongs_to :instructor
  has_many :instructors, through: :subscriptions
  has_many :subscriptions, dependent: :destroy

  before_save :should_generate_new_friendly_id?, if: :username_changed?
  before_save :downcase_username

  def validate_username
    if Student.where(email: username).exists?
      errors.add(:username, :invalid)
    end
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end

  def subscribed?(instructor)
    Subscription.exists? student_id: id, instructor_id: instructor.id
  end

  def unsubscribe(instructor)
    Subscription.find_by(student_id: id, instructor_id: instructor.id).destroy
  end

  def subscription_id(instructor)
    Subscription.find_by(student_id: id, instructor_id: instructor.id).id
  end

  def bookmarked?(course)
    Bookmark.exists? student_id: id, course_id: course.id
  end

  def unbookmark(course)
    Bookmark.find_by(student_id: id, course_id: course.id).destroy
  end

  def bookmark_id(course)
    Bookmark.find_by(student_id: id, course_id: course.id).id
  end

  def purchased?(course)
    Purchase.where("stripe_charge_id like ?", "%ch%").exists? student_id: id, course_id: course.id
  end

  def purchase_id(course)
    Purchase.find_by(student_id: id, course_id: course.id).id
  end

  private

    def should_generate_new_friendly_id?
      username_changed?
    end

    def downcase_username
      self.username = username.downcase
    end

end

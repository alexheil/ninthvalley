class Instructor < ApplicationRecord
  extend FriendlyId
  friendly_id :username, use: :slugged

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :timeoutable
   #:omniauthable, :confirmable, :lockable

  attr_accessor :login
  attr_accessor :currency
  attr_accessor :plan_amount

  validates :username, presence: true, uniqueness: true, length: { maximum: 50 }, format: { with: /\A[a-zA-Z0-9]+\Z/i }
  validate :validate_username

  has_one :profile, dependent: :destroy
  has_one :merchany, dependent: :destroy

  has_many :posts, dependent: :destroy
  has_many :courses, dependent: :destroy
  has_many :tracks, dependent: :destroy
  has_many :videos, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :comments, dependent: :destroy

  #has_many :subscriptions, dependent: :destroy
  #has_many :students, through: :subscriptions

  before_save :should_generate_new_friendly_id?, if: :username_changed?
  before_save :downcase_username

  def validate_username
    if Instructor.where(email: username).exists?
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

  private

    def should_generate_new_friendly_id?
      username_changed?
    end

    def downcase_username
      self.username = username.downcase
    end

end

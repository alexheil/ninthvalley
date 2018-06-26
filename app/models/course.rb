class Course < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  enum refund_policy: [:zero, :three, :seven]

  include ImageUploader[:image]

  belongs_to :instructor
  belongs_to :category
  belongs_to :subcategory, optional: true

  belongs_to :student, optional: true
  has_many :students, through: :purchases
  has_many :purchases

  has_many :reviews, dependent: :destroy
  has_many :tracks, dependent: :destroy
  has_many :videos, through: :tracks

  validates :instructor_id, presence: true
  validates :category_id, presence: true
  validates :title, presence: true, length: { maximum: 255 }
  validates :image_data, presence: true, unless: :image_data?
  validates :tagline, presence: true, length: { maximum: 255 }
  validates :language, presence: true
  validates :description, presence: true, length: { maximum: 65536 }
  validates :requirements, presence: true, length: { maximum: 5000 }
  validates :description, presence: true, length: { maximum: 5000 }
  validates :highlights, presence: true, length: { maximum: 5000 }
  validates :target, presence: true, length: { maximum: 5000 }

  validates :paid, presence: true, if: :is_paid
  validates :price, presence: true, length: { maximum: 9 }, numericality: { greater_than: 0}, if: :is_paid
  validates :currency, presence: true, if: :is_paid
  validates :refund_policy, presence: true, if: :is_paid

  before_save :should_generate_new_friendly_id?, if: :title_changed?
    
  def average_rating
    reviews.sum(:rating) / reviews.size if reviews.any?
  end

  def self.search(search)
    where("title LIKE ?", "%#{search}%")
  end

  private

    def should_generate_new_friendly_id?
      title_changed?
    end

    def is_paid
      self.paid?
    end

end
class Purchase < ApplicationRecord

  belongs_to :course
  belongs_to :instructor
  belongs_to :student

  has_many :notifications, dependent: :destroy

  validates :course_id, presence: true
  validates :instructor_id, presence: true
  validates :student_id, presence: true
  validates :stripe_charge_id, presence: true
  #validates :use_your_card, presence: true
  validates :price, presence: true, length: { maximum: 9 }, numericality: { greater_than: 0}
  validates :currency, presence: true
  
end

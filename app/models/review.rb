class Review < ApplicationRecord

  default_scope -> { order('created_at DESC') }

  belongs_to :instructor
  belongs_to :course
  belongs_to :student

  has_many :notifications, dependent: :destroy

  validates :student_id, :uniqueness => {:scope => :course_id}, presence: true
  validates :course_id, presence: true
  validates :instructor_id, presence: true
  validates :rating, presence: true, length: { maximum: 1 }
  validates :content, presence: true, length: { maximum: 5000 }
  
end

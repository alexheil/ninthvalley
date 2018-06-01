class Review < ApplicationRecord

  default_scope -> { order('created_at DESC') }

  belongs_to :instructor
  belongs_to :course
  belongs_to :student

  validates :student_id, :uniqueness => {:scope => :course_id}, presence: true
  
end

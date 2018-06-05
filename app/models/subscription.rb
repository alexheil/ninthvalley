class Subscription < ApplicationRecord

  belongs_to :instructor
  belongs_to :student

  validates :instructor_id, presence: true
  validates :student_id, presence: true
  
end

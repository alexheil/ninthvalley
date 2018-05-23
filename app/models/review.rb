class Review < ApplicationRecord

  belongs_to :instructor
  belongs_to :course
  belongs_to :student
  
end

class Purchase < ApplicationRecord

  belongs_to :course
  belongs_to :instructor
  belongs_to :student
  
end

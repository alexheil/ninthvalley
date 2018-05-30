class Purchase < ApplicationRecord

  attr_accessor :use_card

  belongs_to :course
  belongs_to :instructor
  belongs_to :student
  
end

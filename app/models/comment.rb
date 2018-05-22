class Comment < ApplicationRecord

  belongs_to :video
  belongs_to :instructor
  belongs_to :student
  
end

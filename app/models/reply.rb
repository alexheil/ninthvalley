class Reply < ApplicationRecord

  belongs_to :instructor
  belongs_to :student
  belongs_to :message
  
end

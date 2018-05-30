class Subscription < ApplicationRecord

  belongs_to :instructor
  belongs_to :student
  
end

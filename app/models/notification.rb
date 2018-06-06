class Notification < ApplicationRecord

  belongs_to :instructor
  belongs_to :student
  belongs_to :review
  belongs_to :comment
  belongs_to :purchase
  belongs_to :subscription
  
end

class Message < ApplicationRecord

  belongs_to :instructor
  belongs_to :student

  has_many :replies, dependent: :destroy

end

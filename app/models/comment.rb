class Comment < ApplicationRecord

  belongs_to :video
  belongs_to :instructor
  belongs_to :student

  has_many :notifications, dependent: :destroy

  validates :video_id, presence: true
  validates :content, presence: true, length: { maximum: 1000 }
  
end

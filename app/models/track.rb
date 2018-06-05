class Track < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :instructor
  belongs_to :course

  has_many :videos, dependent: :destroy

  before_save :should_generate_new_friendly_id?, if: :title_changed?
    
  validates :instructor_id, presence: true
  validates :course_id, presence: true
  validates :title, presence: true, length: { maximum: 255 }

  private

    def should_generate_new_friendly_id?
      title_changed?
    end

end

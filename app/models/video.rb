class Video < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  include VideoUploader[:video]

  belongs_to :instructor
  belongs_to :course
  belongs_to :track

  has_many :comments, dependent: :destroy

  validates :instructor_id, presence: true
  validates :track_id, presence: true
  validates :title, presence: true, length: { maximum: 255 }
  validates :video_data, presence: true, unless: :video_data?
  validates :description, presence: true, length: { maximum: 5000 }

  before_save :should_generate_new_friendly_id?, if: :title_changed?
    
  private

    def should_generate_new_friendly_id?
      title_changed?
    end
    
end

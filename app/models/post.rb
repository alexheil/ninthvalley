class Post < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  include ImageUploader[:image]

  belongs_to :instructor

  before_save :should_generate_new_friendly_id?, if: :title_changed?
    
  validates :instructor_id, presence: true
  validates :title, presence: true, length: { maximum: 255 }
  validates :image_data, presence: true, unless: :image_data?
  validates :description, presence: true, length: { maximum: 65536 }
   
  private

    def should_generate_new_friendly_id?
      title_changed?
    end
    
end

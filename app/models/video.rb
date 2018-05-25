class Video < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  include VideoUploader[:video]

  belongs_to :instructor
  belongs_to :course
  belongs_to :track

  has_many :comments, dependent: :destroy

  before_save :should_generate_new_friendly_id?, if: :title_changed?
    
  private

    def should_generate_new_friendly_id?
      title_changed?
    end
    
end

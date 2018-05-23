class Track < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :instructor
  belongs_to :course

  has_many :videos

  before_save :should_generate_new_friendly_id?, if: :title_changed?
    
  private

    def should_generate_new_friendly_id?
      title_changed?
    end

end
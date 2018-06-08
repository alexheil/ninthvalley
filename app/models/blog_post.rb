class BlogPost < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  default_scope -> { order('id DESC') }

  before_save :should_generate_new_friendly_id?, if: :title_changed?

  validates :title, presence: true, length: { maximum: 255 }
  validates :image, presence: true, length: { maximum: 255 }
  validates :content, presence: true, length: { maximum: 65536 }
   
  private

    def should_generate_new_friendly_id?
      title_changed?
    end
    
end

class Course < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :instructor
  belongs_to :category
  belongs_to :subcategory

  has_many :reviews
  has_many :tracks

  before_save :should_generate_new_friendly_id?, if: :title_changed?
    
  private

    def should_generate_new_friendly_id?
      title_changed?
    end

end
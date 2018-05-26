class Course < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  include ImageUploader[:image]

  belongs_to :instructor
  belongs_to :category
  belongs_to :subcategory

  #belongs_to :students

  has_many :reviews, dependent: :destroy
  has_many :tracks, dependent: :destroy
  has_many :videos, through: :tracks

  before_save :should_generate_new_friendly_id?, if: :title_changed?
    
  private

    def should_generate_new_friendly_id?
      title_changed?
    end

end
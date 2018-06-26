class Profile < ApplicationRecord

  include ImageUploader[:image]

  validates :first_name, format: { with: /\A[-a-z]+\z/i }, allow_blank: true
  validates :last_name, format: { with: /\A[-a-z]+\z/i }, allow_blank: true
  validates :biography, length: { maximum: 4000 }, allow_blank: true
  validates :website, format: { with: /\A((http|https)?:\/\/)?(www.)?[a-zA-Z0-9]+.[a-z]+\/?/i }, allow_blank: true
  validates :twitter_handle, length: { maximum: 15 }, allow_blank: true
  validates :youtube_handle, length: { maximum: 75 }, allow_blank: true

  belongs_to :instructor, optional: true
  belongs_to :student, optional: true

  before_save :create_twitter_url
  before_save :create_youtube_url
  before_save :smart_add_url_protocol
  before_save :downcase

  private

    def create_twitter_url
      self.twitter_url = nil if self.twitter_handle.blank?
      self.twitter_url = "https://twitter.com/#{self.twitter_handle}" if self.twitter_handle.present?
    end

    def create_youtube_url
      self.youtube_url = nil if self.youtube_handle.blank?
      self.youtube_url = "https://youtube.com/#{self.youtube_handle}" if self.youtube_handle.present?
    end

    def smart_add_url_protocol
      unless self.website[/\Ahttp:\/\//] || self.website[/\Ahttps:\/\//]
        self.website = "https://#{self.website}" unless website.blank?
      end
    end

    def downcase
      self.twitter_url = twitter_url.downcase if self.twitter_url.present?
      self.website = website.downcase if self.website.present?
    end
  
end

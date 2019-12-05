class ShortenedUrl < ApplicationRecord
  before_create :create_shortened_url
  before_create :create_sanitized_original_url
  # Regex borrowed and modified from https://stackoverflow.com/a/13311941
  validates_format_of :original_url, with: /^(((http|https):\/\/|)?[a-z0-9]+([\-\.][a-z0-9]+)*\.[a-z]{2,6}(:[0-9]{1,5})?(\/.*)?)$/, multiline: true

  def create_shortened_url
    self.shortened_url_token = SecureRandom.hex(3)
  end

  # Regex source: https://stackoverflow.com/a/7908693
  def create_sanitized_original_url
    unless self.original_url[/\Ahttp:\/\//] || self.original_url[/\Ahttps:\/\//]
      self.sanitized_original_url = "http://#{self.original_url}"
    else
      self.sanitized_original_url = self.original_url
    end
  end
end

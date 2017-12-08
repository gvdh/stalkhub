require 'ruby-instagram-scraper'
require 'json'
require 'open-uri'
require 'jsonpath'

class InstaObjectService

  def initialize
    InstaJob.perform_later(username)
  end

  def get_photos_url
    doc = RubyInstagramScraper.get_user_media_nodes(@username)
    data = doc.to_s.scan(/(?<=display_src"=>")[^"]+/)
    data.each do |photo|
      puts photo
    end
  end
end

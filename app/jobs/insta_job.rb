class InstaJob < ApplicationJob
  queue_as :default

  def perform(username)
    doc = RubyInstagramScraper.get_user_media_nodes(username)
    data = doc.to_s.scan(/(?<=display_src"=>")[^"]+/)
    data.each do |photo|
      puts photo
    end
  end
end

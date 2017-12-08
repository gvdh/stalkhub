require 'ruby-instagram-scraper'

class InstaObjectService

  def initialize(user)
    @user = user
  end

  def get_photos_url(test)
    doc = RubyInstagramScraper.get_user_media_nodes(test)
    data = doc.to_s.scan(/(?<=display_src"=>")[^"]+/)
    data.each do |photo|
      Result.create!(
        user: @user,
        category: "photo",
        picture: photo
      )
    end
  end
end

class InstaJob < ApplicationJob
  queue_as :default

  def perform(username, user_id)
    @user = user_id
    doc = RubyInstagramScraper.get_user_media_nodes(username)
    data = doc.to_s.scan(/(?<=display_src"=>")[^"]+/)
    data.each do |photo|

    Result.create!(
      user: user_id,
      name: @username,
      category: "photo",
      picture: photo,
      )
    end
  end
end

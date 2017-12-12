class InstaJob < ApplicationJob
  queue_as :default

  def perform(username, user_id)
    @user = user_id
    doc = RubyInstagramScraper.get_user_media_nodes(username)
    data = doc.to_s.scan(/(?<=display_src"=>")[^"]+/)

    puts data

    if data == nil
      redirect_to root_path
    else
      data.each do |photo|

        Result.create!(
          user: user_id,
          name: @username,
          category: "photo",
          picture: photo
      )
      end
    end
  end
end

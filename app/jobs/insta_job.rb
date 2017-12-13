class InstaJob < ApplicationJob
  queue_as :default

  def perform(username, current_user, provider)
    @provider = provider
    @user = current_user
    @username = username
    doc = RubyInstagramScraper.get_user_media_nodes(username)
    data = doc.to_s.scan(/(?<=display_src"=>")[^"]+/)
    if data.empty?
      Result.create!(
        user: @user,
        name: @username,
        picture: "http://blogs.covchurch.org/wp-content/uploads/sites/40/2012/08/Nothing_512_512.jpg"
        )
    else
      data.each do |photo|

        Result.create!(
          user: @user,
          name: @username,
          category: "photo",
          picture: photo,
          provider: @provider
      )
      end
    end
  end
end

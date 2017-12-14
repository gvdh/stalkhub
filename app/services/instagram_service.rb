class InstagramService

  def initialize(username, user, provider)
    @provider = provider
    @user = user
    @username = username
    @doc = RubyInstagramScraper.get_user(username)
    @avatar = @doc["profile_pic_url"]
  end

  def getting_infos
    @user.results.destroy_all
    @doc["media"]["nodes"].each do |post|
      puts post
      picture = post.to_s.scan(/(?<=display_src"=>")[^"]+/).first if post.to_s.scan(/(?<=display_src"=>")[^"]+/).any?
      link = "https://www.instagram.com/p/#{post['code']}"
      likes = post["likes"]["count"]
      caption = post["caption"]
        Result.create!(
          total_likes: likes,
          text: caption,
          link: link,
          avatar: @avatar,
          user: @user,
          username: @username,
          category: "instagram",
          picture: picture,
          provider: @provider
        )
    end
  end
end

require 'koala'

class GraphObjectService
  UPLOADED_PHOTOS_FIELDS = "me?fields=albums{privacy,photos{name,link,created_time,images}}"
  UPLOADED_POSTS_FIELDS = "me?fields=posts{privacy,message, created_time,story,attachments}"

  def initialize(token)
    @token = token
  end

  def get_uploaded_photos
    results = []
    @graph = Koala::Facebook::API.new(@token)
    photos =  @graph.get_object(UPLOADED_PHOTOS_FIELDS)
    photos["albums"]["data"].each do |data|
      album_privacy = data["privacy"]
      unless data["photos"].nil?
        data["photos"]["data"].each do |photo|
          caption = photo["name"] unless photo["name"].nil?
          attachments = photo["images"] unless photo["images"].nil?
          created_time = photo["created_time"]
          photo_link = photo["link"]
          id = photo["id"]
          results << {
            caption: caption,
            link: photo_link,
            privacy: album_privacy,
            category: "photo",
            attachments: attachments,
            created_time: created_time
          }
        end
      end
    end
    return results
  end

  def get_uploaded_posts
    results = []
    @graph = Koala::Facebook::API.new(@token)
    posts =  @graph.get_object(UPLOADED_POSTS_FIELDS)
    puts posts.next_page
    until posts.next_page.nil?
      unless posts["posts"]["data"].nil?
        posts["posts"]["data"].each do |post|
          results << post
        end
      posts = posts.next_page
    end
    end
    puts results
  end

end


c = GraphObjectService.new(TOKEN)
c.get_uploaded_posts
c.get_uploaded_photos


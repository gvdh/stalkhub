require 'koala'

class GraphObjectService
  UPLOADED_PHOTOS_FIELDS = "me?fields=albums{privacy,photos{name,link,created_time,images}}"

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
          result = {
            caption: caption,
            link: photo["link"],
            privacy: album_privacy,
            category: "photo",
            attachments: attachments,
            created_time: photo["created_time"]
                  }
        results << result
        end
      end
    end
    puts results
  end


end


c = GraphObjectService.new(TOKEN)
c.get_uploaded_photos


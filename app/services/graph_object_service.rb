require 'koala'

class GraphObjectService
  UPLOADED_PHOTOS_FIELDS = "albums{privacy,photos{name,link,created_time,images}}"

  def initialize(token)
    @token = token
  end

  def get_uploaded_photos
    @graph = Koala::Facebook::API.new(@token)
    photos =  @graph.get_object("me?fields=" + UPLOADED_PHOTOS_FIELDS )
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
        puts result
        end
      end
    end
  end


end


c = GraphObjectService.new("EAACEdEose0cBAFCjjxEBZCkpVAS1FbQzW1Ne2W4KIu7AZBZBHRZCn4RgoJi6ZCZCi4nBS5YdMODIZBrpwDlbkPbiA6UiyEevApd2kfHAtJx15mGhoiQnVErtyyc8mC27BZBvigxTRLWhOVFZBMxEdzSk4pZBGmZARKUJ5RXmrGP4jWfDM8AUkKfwZBzqosl0J2jpn88ZD")
c.get_uploaded_photos

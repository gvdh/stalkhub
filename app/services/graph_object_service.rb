require 'koala'

class GraphObjectService
  UPLOADED_PHOTOS_FIELDS = "me?fields=albums{privacy,photos{name,link,created_time,images}}"

  def initialize(token)
    @token = token
  end

  def get_uploaded_photos
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
        puts result
        end
      end
    end
  end


end


c = GraphObjectService.new("EAACEdEose0cBANNFh3sSHdw22ws6ZBYgPLqetc3GftarCgdqRbh1TPsyUlFVOalXzfzp1ZBZB0iMwIAZBvc9mdZALBYpJOq09VrzIwCIoT5Yu8gnhMVZBGO3WBsvlpezydXqJdfjr3ksRoQd7VM0dFBvY3E4Yhs0ZBBcorx40UCgohdNha49ukjMBmVp5pPPmMtYwo9NcCFDAZDZD")
c.get_uploaded_photos


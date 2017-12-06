require 'koala'

Koala.config.api_version = "v2.11"

class GraphObjectService
  PHOTOS_FIELDS = "me/photos?fields=name,link,created_time,picture"
  UPLOADED_POSTS_FIELDS = "me/posts?fields=privacy,message, created_time,story,attachments,permalink_url,type"
  LIKED_PAGES = "me/likes?fields=fan_count,name,picture,link"
  TAGGED_VIDEOS_FIELDS = "me/videos?fields=privacy,created_time,description"
  UPLOADED_VIDEOS_FIELDS = "me/videos/uploaded?fields=privacy,created_time,description"

  def initialize(provider)
    @token = provider.token
    @user = provider.user
  end


  def get_photos
    @graph = Koala::Facebook::API.new(@token)
    photos =  @graph.get_object(PHOTOS_FIELDS)
    page = 1
    until photos.next_page.nil? && page != 1
      photos.each do |photo|
        ze_photo = photo["likes"]["summary"]["total_count"] if photo["likes"]
        if Result.find_by_node_id(photo["id"]).nil?
          Result.create!(
            user: @user,
            category: "photo",
            created_time: photo["created_time"],
            picture: photo["picture"],
            node_id: photo["id"],
            total_likes: ze_photo
            )
        else
          puts "Result already exists !"
        end
      end
      photos = photos.next_page if !(photos.next_page.nil?)
      page += 1
    end
  end

  def get_uploaded_posts
    @graph = Koala::Facebook::API.new(@token)
    posts =  @graph.get_object(UPLOADED_POSTS_FIELDS)
    page = 1
    until posts.next_page.nil? && page != 1
      posts.each do |post|
        if Result.find_by_node_id(post["id"]).nil?
          Result.create!(
            user: @user,
            category: post["type"],
            privacy: post["privacy"]["value"],
            created_time: post["created_time"],
            story: post["story"],
            node_id: post["id"],
            attachments: post["attachments"],
            link: post["permalink_url"]
            )
        else
          puts "Result already exists !"
        end
      end
      posts = posts.next_page if !(posts.next_page.nil?)
      page +=1
    end
  end

  def get_liked_pages
    @graph = Koala::Facebook::API.new(@token)
    actual_page = @graph.get_object(LIKED_PAGES)
    page = 1
    until actual_page.next_page.nil? && page != 1
      actual_page.each do |page|
        if Result.find_by_node_id(page["id"]).nil?
          Result.create!(
            user: @user,
            category: "page",
            name: page["name"],
            picture: page["picture"]["data"]["url"],
            link: page["link"],
            fan_count: page["fan_count"],
            node_id: page["id"]
          )
        else
          puts "Result already exists !"
        end
      end
      actual_page = actual_page.next_page if !(actual_page.next_page.nil?)
      page += 1
    end
  end

  def get_tagged_videos
    @graph = Koala::Facebook::API.new(@token)
    videos = @graph.get_object(UPLOADED_VIDEOS_FIELDS)
    page = 1
    until videos.next_page.nil? && page != 1
      videos.each do |video|
        likes = video["likes"]["summary"]["total_count"] if video['likes']
        if Result.find_by_node_id(video["id"]).nil?
          Result.create!(
            user: @user,
            category: "video",
            privacy: video["privacy"]["value"],
            created_time: video["created_time"],
            description: video["description"],
            node_id: video["id"],
            total_likes: likes
          )
        else
          puts "Result already exists !"
        end
      end
      videos = videos.next_page if !(videos.next_page.nil?)
      page += 1
    end
  end

  def get_uploaded_videos
    @graph = Koala::Facebook::API.new(@token)
    videos = @graph.get_object(UPLOADED_VIDEOS_FIELDS)
    page = 1
    until videos.next_page.nil? && page != 1
      videos.each do |video|
        likes = video["likes"]["summary"]["total_count"] if video['likes']
        if Result.find_by_node_id(video["id"]).nil?
          Result.create!(
            user: @user,
            category: "video",
            privacy: video["privacy"]["value"],
            created_time: video["created_time"],
            description: video["description"],
            node_id: video["id"],
            total_likes: likes
          )
        else
          puts "Result already exists !"
        end
      end
      videos = videos.next_page if !(videos.next_page.nil?)
      page += 1
    end
  end

end






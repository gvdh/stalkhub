require 'koala'

Koala.config.api_version = "v2.11"

class GraphObjectService
  PHOTOS_FIELDS = "me/photos?fields=name,link,created_time,picture,images"
  UPLOADED_POSTS_FIELDS = "me/posts?fields=privacy,message, created_time,story,attachments,permalink_url,type"
  LIKED_PAGES = "me/likes?fields=fan_count,name,picture,link"
  TAGGED_VIDEOS_FIELDS = "me/videos?fields=privacy,created_time,description, source, picture, permalink_url"
  UPLOADED_VIDEOS_FIELDS = "me/videos/uploaded?fields=privacy,created_time,description, source, picture, permalink_url"

  def initialize(provider)
    @provider = provider
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
        text = photo["name"] if photo["name"]
        image = photo["images"].first["source"] if photo["images"]
        if Result.find_by_node_id(photo["id"]).nil? || Result.find_by_node_id(photo["id"]).user != @user
          begin
            Result.create!(
              provider: @provider,
              user: @user,
              category: "photo",
              text: text,
              date: photo["created_time"],
              picture: image,
              node_id: photo["id"],
              link: photo["link"],
              total_likes: ze_photo
              )
          rescue
            puts "Creation of result #{photo["id"]} failed !"
          end
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
        if Result.find_by_node_id(post["id"]).nil? || Result.find_by_node_id(post["id"]).user != @user
          parsed_post = post.to_s
          if post.to_s.include?("\"image\"")
            attachment = parsed_post.delete(" ").scan(/(?<=\"src\"=>\")[^\"]+/).join
          else
            attachment = ""
          end
          text = post["message"] || post["story"]
          begin
            Result.create!(
              provider: @provider,
              user: @user,
              category: "post",
              privacy: post["privacy"]["value"],
              date: post["created_time"],
              text: text,
              node_id: post["id"],
              picture: attachment,
              link: post["permalink_url"]
              )
          rescue
            puts "Creation of result #{post["id"]} failed !"
          end
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
        if Result.find_by_node_id(page["id"]).nil? || Result.find_by_node_id(page["id"]).user != @user
          begin
            Result.create!(
              provider: @provider,
              user: @user,
              category: "page",
              text: page["name"],
              picture: page["picture"]["data"]["url"],
              link: page["link"],
              fan_count: page["fan_count"],
              node_id: page["id"]
            )
          rescue
            fail
            puts "Creation of result #{page["id"]} failed !"
          end
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
        text = video["description"] if video["description"]
        if Result.find_by_node_id(video["id"]).nil? || Result.find_by_node_id(video["id"]).user != @user
          begin
            Result.create!(
              provider: @provider,
              user: @user,
              category: "video",
              privacy: video["privacy"]["value"],
              date: video["created_time"],
              text: text,
              node_id: video["id"],
              total_likes: likes,
              link: "https://www.facebook.com/"+video["permalink_url"],
              picture: video["picture"]
            )
          rescue
            puts "Creation of result #{video["id"]} failed !"
          end
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
        text = video["description"] if video["description"]
        if Result.find_by_node_id(video["id"]).nil? || Result.find_by_node_id(video["id"]).user != @user
          begin
            Result.create!(
              provider: @provider,
              user: @user,
              category: "video",
              privacy: video["privacy"]["value"],
              date: video["created_time"],
              text: video["description"],
              node_id: video["id"],
              total_likes: likes,
              link: "https://www.facebook.com/"+video["permalink_url"],
              picture: video["picture"]
            )
          rescue
            puts "Creation of result #{video["id"]} failed !"
          end
        else
          puts "Result already exists !"
        end
      end
      videos = videos.next_page if !(videos.next_page.nil?)
      page += 1
    end
  end
end


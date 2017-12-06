require 'koala'
Koala.config.api_version = "v2.11"

class GraphObjectService
  UPLOADED_PHOTOS_FIELDS = "me/albums?fields=privacy,photos{name,link,created_time,images}"
  UPLOADED_POSTS_FIELDS = "me/posts?fields=privacy,message, created_time,story,attachments"
  LIKED_PAGES = "me/likes?fields=fan_count,name,picture,link&after="
  UPLOADED_VIDEOS_FIELDS = "me/videos?fields=privacy,created_time,description"

  def initialize(token)
    @token = token
  end

  def get_uploaded_photos
    results = []
    @graph = Koala::Facebook::API.new(@token)
    photos =  @graph.get_object(UPLOADED_PHOTOS_FIELDS)
    until photos.next_page.nil?
      photos.each do |data|
        album_privacy = data["privacy"]
        unless data["photos"].nil?
          data["photos"]["data"].each do |photo|
            results << photo
          end
        end
      end
    end
    return results
  end

  def get_uploaded_posts
    results = []
    @graph = Koala::Facebook::API.new(@token)
    posts =  @graph.get_object(UPLOADED_POSTS_FIELDS)
    until posts.next_page.nil?
      posts.each do |post|
        results << post
      end
      posts = posts.next_page
    end
    return results
  end

  def get_liked_pages
    liked_pages = []
    @graph = Koala::Facebook::API.new(@token)
    actual_page = @graph.get_object(LIKED_PAGES)
    until actual_page.next_page.nil?
      actual_page.each do |page|
        liked_pages << page
      end
      actual_page = actual_page.next_page
    end
    return liked_pages
  end


  def get_uploaded_videos
    results = []
    @graph = Koala::Facebook::API.new(@token)
    videos = @graph.get_object(UPLOADED_VIDEOS_FIELDS)
    until videos.next_page.nil?
      videos.each do |video|
        results << video
      end
      videos = videos.next_page
    end
    return results
  end
end


c = GraphObjectService.new("EAACEdEose0cBANvWaEqJVxtVTs6c9uvtZCMgLPeTb5uZAZCItMxZC8U43IhNFnWza7ZAA3jZBpsY3YpFZCajq6DZBXfioYvrQwD1L90izkzOMMKZAkZBbCZBJXgECs6ED8ZAZByVSNaRzZBosZCmZCEwZB10YLqlw0e2vi0Wx4QYa8L6YEhIt9ZBiJZCISsjk3RrkBszv4qj5H0DoGu1tbyqwZDZD")
c.get_uploaded_posts
c.get_uploaded_photos
c.get_liked_pages
c.get_uploaded_videos

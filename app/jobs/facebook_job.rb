class FacebookJob < ApplicationJob
  queue_as :default

  def perform(provider)
    infos = GraphObjectService.new(provider)
    infos.basic_infos
    infos.get_uploaded_videos
    infos.get_tagged_videos
    # infos.get_liked_pages
    infos.get_uploaded_posts
    infos.get_photos
  end

end

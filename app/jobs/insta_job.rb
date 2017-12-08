class InstaJob < ApplicationJob
  queue_as :default

  def perform(username, user_id)
    infos = InstaObjectService.new(User.find(user_id))
    infos.get_photos_url(username)
  end
end

class InstaJob < ApplicationJob
  queue_as :default

  def perform(*args)
    infos = InstaObjectService.new
    infos.get_photos_url
  end
end

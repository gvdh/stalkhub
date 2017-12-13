class InstaJob < ApplicationJob
  queue_as :default

  def perform(username, user_id, provider_id)
    user = User.find(user_id)
    provider = Provider.find(provider_id)
    insta = InstagramService.new(username, user, provider )
    insta.getting_infos
  end

end

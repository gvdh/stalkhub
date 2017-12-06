Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FB_ID'], ENV['FB_SECRET'],
    scope: 'email,user_birthday,public_profile,user_photos,user_posts,user_tagged_places,user_videos'
end

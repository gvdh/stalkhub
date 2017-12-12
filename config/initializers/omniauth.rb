Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FB_ID'], ENV['FB_SECRET'],
    scope: 'email,public_profile,user_photos,user_posts,user_videos,public_profile'
end

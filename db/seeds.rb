require 'koala'

puts "Destroying actual datas..."


Result.destroy_all
Provider.destroy_all
User.destroy_all

puts "Everything has been destroyed ! "

puts "Creating user"

counter = 1
5.times do |usr|
  user = User.create!(email: "user#{counter}@gmail.com", password: "123456")
  puts "User #{counter} created, associating to a provider."
  providr = Provider.create!(
    user_id: user.id,
    name: "facebook",
    token: "EAACEdEose0cBAL8ZCfTS8VaYNH26X2e1FAUUF3iG1c61MddUjbsaWjT5ZB6TZCf93yiVLZAbLbt4UZCiOZCCAUIiBQDypoCXDBrOs9Y3bfCSHni9iJUbhCONZATEGKZAngYv4d4OZBZCQBB4ZCSOAZBDZBQHFsZAll43NZCOYaKavClcHAAJqNiQ1PZAvwOgVOmwZCig1tp0ZD"
    )
  counter+=1
end

puts "Koala facebook api initialization ... "
@graph = Koala::Facebook::API.new("EAACEdEose0cBAL8ZCfTS8VaYNH26X2e1FAUUF3iG1c61MddUjbsaWjT5ZB6TZCf93yiVLZAbLbt4UZCiOZCCAUIiBQDypoCXDBrOs9Y3bfCSHni9iJUbhCONZATEGKZAngYv4d4OZBZCQBB4ZCSOAZBDZBQHFsZAll43NZCOYaKavClcHAAJqNiQ1PZAvwOgVOmwZCig1tp0ZD")
posts = @graph.get_connections("me", "posts")

puts "Success !"

puts "Let's dig some results for #{User.first.email}!"
counter = 1
posts.each do |post|
  puts "Creating result ##{counter} on post #{post["id"]}"
  actual_post = @graph.get_object("#{post["id"]}?fields=privacy,name,message,picture,permalink_url,description,type,attachments")
  Result.create!(
    caption: "#{actual_post["name"]}",
    message: "#{actual_post["description"]}",
    node_id: "#{post["id"]}",
    provider_id: User.first.providers[0].id,
    attachments: "#{actual_post["attachments"]}",
    category: "#{actual_post["type"]}",
    privacy: "#{actual_post["privacy"]["value"]}",
    link: "#{actual_post["permalink_url"]}"
    )
  puts "Successfully created result ##{counter} !"
  counter+= 1
end

# end





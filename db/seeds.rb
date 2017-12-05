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
    token: "EAACEdEose0cBAD876B4w76DIJYh213CYmyRxPRZAIyxZCKi8cZCuG9WhYAKZAQyfVLeRrbq6nZBFGzZCoZCzGZBC8eXIGnXXFqhM4TIO3SNHCau7ZBUqSdK6IUyfQe1o7RFlZCpX5kaf931u4VnJqaIxdQ8q0qwpcZBG8acSpTQWEuznNULQGDi5ZBzZBeYP1Cj1vjNQZD"
    )
  counter+=1
end

puts "Koala facebook api initialization ... "
@graph = Koala::Facebook::API.new("EAACEdEose0cBALLX68ZCseNouHg60ZBUpjFjW62ySly5FbTbb8qPgbqKLHsasMwMDwlHZBaohVJADHnW3lCgsrZBN5Cba4ZAr7UURf0h2ZAaQhUtY921BobPr9Qup1EyjezxAlVoZAayj8VPc7UnuojiJBAvSyBdMlg3gKL79LS5UOHouMLNat0tzfHOblnujUZD")
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





require 'json'
require 'koala'

@graph = Koala::Facebook::API.new("EAACEdEose0cBADpXd4JbiriM7bklCDSJvahljScA3rU3n24NERE0Jtky1E18tjtaTqZCYZAq7zAckO3zkFYVTyM23OnZADHkz3ZAB7BFD2aIYnXlVwZBa7jqQh5Vy9uwHX7OHxtXcLUEjiZBl3WX0cM1hPKJHVJFmQU8BACvIZBYp0IFmvuUTdXghklDUC8hkdzTkIv2DQucQZDZD")


photos =  @graph.get_object("me?fields=albums{name,privacy,photos{link, created_time, picture, likes.summary(total_count) }}")
puts photos["albums"]["data"][1]["photos"]["data"][0]["likes"]["summary"]["total_count"].class

counter = 1
photos["albums"]["data"].each do |data|
  album_privacy = data["privacy"]
  album_name = data["name"]
  album_id = data["id"]
  unless data["photos"].nil?
    data["photos"]["data"].each do |photo|
      created_time = photo["created_time"]
      photo_link = photo["link"]
      number_of_likes = photo["likes"]["summary"]["total_count"]
      puts "##{counter} => Privacy : #{album_privacy} |||| Album : #{album_name} |||| Created : #{created_time} |||| Link : #{photo_link} |||| Album id : #{album_id[0..5]} |||| Number of likes : #{number_of_likes.to_s}."
      counter +=1
    end
  end
end

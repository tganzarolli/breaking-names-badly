require 'stringio'
require 'open-uri'
require 'json'

class UploadService

  APP_URL = 'https://apps.facebook.com/breaking_names_badly'
  USER_COVER = 'https://graph.facebook.com/fql?q=SELECT%20pic_cover%20FROM%20user%20WHERE%20uid=me()&access_token='
  
  def self.user_cover_as_binary(access_token)
    cover_data = open(USER_COVER + access_token).read
    cover_data_map = JSON.parse cover_data
    image_url = cover_data_map['data'][0]['pic_cover']['source']
  end

  def self.upload(graph, blob, message)
    StringIO.open(blob) do |strio|
      response = graph.put_picture(strio, "image/jpeg", { "message" => message })
      photo_id = response['id']
      photo = graph.get_object(photo_id)

      alternative = {
        "name" => message,
        "caption" => "Time to break bad, b*tch!",
       "description" => "Add some chemistry to your timeline, great to use as a cover, Breaking Bad fan or not.",
       "picture" => photo['picture']}
       
      graph.put_wall_post("Check out my Breaking Bad name! You can create your own here #{APP_URL}", {
                     "link" => photo['link'],
                   })
      photo_id
    end
    
  end
end

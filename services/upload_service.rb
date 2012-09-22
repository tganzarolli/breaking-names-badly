require 'stringio'

class UploadService

  APP_URL = 'https://www.facebook.com/breaking-names-badly'

  def self.upload(graph, blob, message)
    StringIO.open(blob) do |strio|
      response = graph.put_picture(strio, "image/jpeg", { "message" => message })
      photo_id = '10151008281030927'response['id']
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

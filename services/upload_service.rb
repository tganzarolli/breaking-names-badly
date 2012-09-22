require 'stringio'

class UploadService
  def self.upload(graph, blob, message)
    StringIO.open(blob) do |strio|
      response = graph.put_picture(strio, "image/jpeg", { "message" => message })
      response['id']
    end
  end
end

class HttpAdapter
  require 'net/http'

  def self.fetch(url)
    ::JSON.parse(Net::HTTP.get(URI(url)))
  end
end

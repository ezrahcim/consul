<<<<<<< HEAD
require "http"

API_ENDPOINT = "https://decide.madrid.es/graphql".freeze

def make_request(query_string)
  HTTP.headers("User-Agent" => "Mozilla/5.0", accept: "application/json")
      .get(
        API_ENDPOINT,
        params: { query: query_string.delete("\n").delete(" ") }
      )
end

query = <<-GRAPHQL
  {
    proposal(id: 1) {
        id,
        title,
        public_created_at
    }
  }
GRAPHQL

response = make_request(query)

puts "Response code: #{response.code}"
puts "Response body: #{response.body}"
=======
require "net/http"

API_ENDPOINT = "https://demo.consulproject.org/graphql".freeze

def make_request(query_string)
  uri = URI(API_ENDPOINT)
  uri.query = URI.encode_www_form(query: query_string.delete("\n").delete(" "))
  request = Net::HTTP::Get.new(uri)
  request[:accept] = "application/json"

  Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |https|
    https.request(request)
  end
end

query = <<-GRAPHQL
  {
    proposal(id: 1) {
        id,
        title,
        public_created_at
    }
  }
GRAPHQL

response = make_request(query)

puts "Response code: #{response.code}"
puts "Response body: #{response.body}"
>>>>>>> 33c62ccbd7c08c99604903bc8f983f3e706ed21d

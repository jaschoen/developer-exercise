require 'google/api_client'

DEVELOPER_KEY = 'AIzaSyCzGuBZnOecnrCe9i9nsfa4DDDO4zVu6OA'
YOUTUBE_API_SERVICE_NAME = 'youtube'
YOUTUBE_API_VERSION = 'v3'

def get_service
  client = Google::APIClient.new(
    :key => DEVELOPER_KEY,
    :authorization => nil,
    :application_name => $PROGRAM_NAME,
    # :application_version => '1.0.0'
  )
  youtube = client.discovered_api(YOUTUBE_API_SERVICE_NAME, YOUTUBE_API_VERSION)

  return client, youtube
end

puts "What would you like to search for?"
query = gets.chomp

client, youtube = get_service
search_response = client.execute!(
  :api_method => youtube.search.list,
  :parameters => {
    :part => 'snippet',
    :q => query,
    :maxResults => 3
  }
)

puts "\nSearch Results"
puts "=============="
search_response.data.items.each do |search_result|
  puts
  puts "Title: #{search_result.snippet.title}"
  puts " URL: https://www.youtube.com/watch?v=#{search_result.id.videoId}"
end
require "net/http"
require "json"

class TmdbService
  BASE_URL = "https://api.themoviedb.org/3"

  def initialize
    @api_key = Rails.application.credentials.dig(:tmdb, :api_key)
  end

  def fetch_popular_movies
    url = URI("#{BASE_URL}/movie/popular?api_key=#{@api_key}")

    response = Net::HTTP.get(url)
    JSON.parse(response)["results"]
  end

  def poster_url(poster_path)
    return nil unless poster_path
    "https://image.tmdb.org/t/p/w500#{poster_path}"
  end
end

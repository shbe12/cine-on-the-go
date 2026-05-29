# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require "open-uri"

puts "Cleaning database..."
Movie.destroy_all

puts "Fetching movies from TMDB..."

service = TmdbService.new
movies = service.fetch_popular_movies

movies.each do |m|
  movie = Movie.create!(
    title: m["title"],
    description: m["overview"],
    year: m["release_date"]&.first(4),
    director: "Unknown", # TMDB needs extra API call for director (optional upgrade)
    genre: "Movie"
  )

  if m["poster_path"]
    file = URI.open(service.poster_url(m["poster_path"]))

    movie.poster.attach(
      io: file,
      filename: "#{m["title"].parameterize}.jpg",
      content_type: "image/jpeg"
    )
  end

  puts "Created #{movie.title}"
end

puts "Done!"

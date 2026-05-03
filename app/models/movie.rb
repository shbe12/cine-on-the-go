class Movie < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true
  validates :year, presence: true
  validates :director, presence: true
  validates :genre, presence: true
  has_many :reviews, dependent: :destroy

  def self.top_rated
    Movie.joins(:reviews)
         .group("movies.id")
         .order("AVG(reviews.rating) DESC")
  end
end

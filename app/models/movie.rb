class Movie < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true
  validates :year, presence: true
  validates :director, presence: true
  validates :genre, presence: true
  has_many :reviews, dependent: :destroy
end

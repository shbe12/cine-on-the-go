class MoviesController < ApplicationController
  before_action :set_movie, only: [:show, :destroy]
  def index
    @movies = Movie.all
  end

  def top
    @movies = Movie.top_rated
  end

  def show
    @review = Review.new
    @reviews = @movie.reviews
  end

  # def edit
  # end

  # def update
  #   if @movie.update(movie_params)
  #     redirect_to movie_path(@movie)
  #   else
  #     render :edit
  #   end
  # end

  def destroy
    @movie.destroy
    redirect_to movies_path, status: :see_other
  end

  private

  def movie_params
    params.require(:movie).permit(:title, :description, :year, :director, :genre)
  end

  def set_movie
    @movie = Movie.find(params[:id])
  end
end

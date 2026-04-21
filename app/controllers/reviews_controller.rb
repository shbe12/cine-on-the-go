class ReviewsController < ApplicationController
    before_action :set_review, only: [:edit, :update, :destroy]
  def create
    @movie = Movie.find(params[:movie_id])
    @review = @movie.reviews.build(review_params)
    if @review.save
      redirect_to movie_path(@movie)
    else
      render "movies/show", status: :unprocessable_entity
    end
  end

  def edit

  end

  def update

    if @review.update(review_params)
      redirect_to movie_path(@review.movie)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy

    @review.destroy
    redirect_to movie_path(@review.movie), status: :see_other
  end

  private

  def review_params
    params.require(:review).permit(:content, :rating)
  end

  def set_review
    @review = Review.find(params[:id])
  end

end

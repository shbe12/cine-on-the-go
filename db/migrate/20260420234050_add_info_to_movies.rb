class AddInfoToMovies < ActiveRecord::Migration[7.1]
  def change
    add_column :movies, :year, :integer
    add_column :movies, :director, :string
    add_column :movies, :genre, :string
  end
end

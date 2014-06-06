class FavouritesController < ApplicationController
  before_action :authenticate_user!
  def create
    current_user.favourites.create(book_id: params[:id])
    finished = current_user.finished_books.find_by(book_id: params[:id])
    finished.destroy if finished
    redirect_to books_path
  end

  def index
    @q = Book.search(params[:q])
    @favourites = @q.result.page(params[:page])
    @books_id = []
    @favourites.each do |book|
      book.favourites.each do |fav|
        @books_id << book.id if fav.user_id == current_user.id
      end
    end
  end

  def destroy
    favourite = Favourite.find_by(book_id: params[:id], user_id: current_user.id)
    favourite.destroy
    redirect_to :back
  end
end

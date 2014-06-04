class FavouritesController < ApplicationController
  before_action :authenticate_user!
  def create
    current_user.favourites.create(book_id: params[:book_id].to_i)
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
    favourite = Favourite.find(params[:id])
    prev_page = request.referer
    favourite.destroy
    # redirect_to :back
    redirect_to prev_page
  end
end

class FavouritesController < ApplicationController
  before_action :authenticate_user!
  include ApplicationHelper


  def create
    finished = current_user.finished_books.find_by(book_id: params[:id])
    finished.destroy if finished
    @favourite = current_user.favourites.create(book_id: params[:id])

    redirect_to books_path, notice: "Dodano książkę do przeczytania."
     flash[:reverting] = "#{undo_link(@favourite, also_to_revert: finished)}"
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
    @favourite = current_user.favourites.find_by(book_id: params[:id])
    @favourite.destroy
    redirect_to :back, notice: "Usunięto książkę z listy do przeczytania."
    flash[:reverting] = "#{undo_link(@favourite, scope: :scoped)}"
  end
end

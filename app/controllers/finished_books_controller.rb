class FinishedBooksController < ApplicationController
  before_action :authenticate_user!
  include ApplicationHelper

  def create
    favourite = current_user.favourites.find_by(book_id: params[:id])
    favourite.destroy if favourite
    @finished = current_user.finished_books.create(book_id: params[:id])

    redirect_to books_path, notice: "Dodano książkę do przeczytanych."
    flash[:reverting] = "#{undo_link(@finished, also_to_revert: favourite)}"
  end

  def index
    @q = Book.search(params[:q])
    @finished_books = @q.result.page(params[:page]).per(20)
    @books_id = []
    @finished_books.each do |book|
      book.finished_books.each do |fin|
        @books_id << book.id if fin.user_id == current_user.id
      end
    end
  end

  def destroy
    @finished = @current_user.finished_books.find_by(book_id: params[:id])
    @finished.destroy
    redirect_to :back, notice: "Usunięto książkę z listy przeczytanych."
    flash[:reverting] = "#{undo_link(@finished, scope: :scoped)}"
  end
end

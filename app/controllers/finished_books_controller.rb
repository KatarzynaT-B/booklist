class FinishedBooksController < ApplicationController
  before_action :authenticate_user!
  def create
    current_user.finished_books.create(book_id: params[:id])
    redirect_to books_path
  end

  def index
    @q = Book.search(params[:q])
    @finished_books = @q.result.page(params[:page])
    @books_id = []
    @finished_books.each do |book|
      book.finished_books.each do |fin|
        @books_id << book.id if fin.user_id == current_user.id
      end
    end
  end

  def destroy
    finished = FinishedBook.find_by(book_id: params[:id], user_id: current_user.id)
    finished.destroy
    redirect_to :back
  end
end

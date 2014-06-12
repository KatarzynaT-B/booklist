class BooksController < ApplicationController
  def index
    @q = Book.search(params[:q])
    @books = @q.result.page(params[:page]).per(20)
  end

  def show
    @book = Book.find(params[:id])
  end
end

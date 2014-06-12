class Book < ActiveRecord::Base
  has_many :users, through: :favourites
  has_many :users, through: :finished_books
  has_many :favourites
  has_many :finished_books

  has_paper_trail

  # self.per_page = 10

  scope :recently_modified, -> {  where("date(updated_at) < ?", 7.days.ago)  }
  scope :wolne_lektury, -> {  where("source = ?", "http://wolnelektury.pl/api/books/")  }
end

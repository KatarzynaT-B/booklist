class Book < ActiveRecord::Base
  has_many :users, through: :favourites
  has_many :users, through: :finished_books
  has_many :favourites
  has_many :finished_books
  self.per_page = 20
end

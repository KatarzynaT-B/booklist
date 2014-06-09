class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :books, through: :favourites
  has_many :books, through: :finished_books
  has_many :favourites
  has_many :finished_books

  has_paper_trail meta: { timestamp: Time.now }
end

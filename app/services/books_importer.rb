require 'faraday'
require 'faraday_middleware'

class BooksImporter

  DEFAULT_URL = 'http://wolnelektury.pl/api/books/'

  def initialize(site_url=BooksImporter::DEFAULT_URL)
    @site_url = site_url
  end

  def import
    books = fetch(@site_url)

    books.each do |book_hash|
      book_url = book_hash["href"]
      book_details = fetch(book_url)
      book = Book.find_or_create_by(
        title: book_hash["title"],
        author: book_hash["author"
      ])
      params = prepare_params(book_hash, book_details)
      book.update(params)
    end
  end

  private

  def fetch(url)
    connection = Faraday.new(url: url) do |con|
      con.response :json, :content_type => /\bjson$/
      con.adapter Faraday.default_adapter
    end
    connection.get.body
  end

  def prepare_params(book_hash, book_data)
    {
      kind: book_hash["kind"],
      url: book_hash["url"],
      epoch: book_hash["epoch"],
      genre: book_hash["genre"],
      epub: book_data["epub"].present?,
      mobi: book_data["mobi"].present?,
      pdf: book_data["pdf"].present?,
      txt: book_data["txt"].present?,
      audio: book_data["media"].present? && !(book_data["media"].empty?)
    }
  end
end

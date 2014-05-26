require 'faraday'
require 'faraday_middleware'

class BooksImporter

  def initialize(url)
    @connection = connect(url)
  end

  def connect(url)
    Faraday.new(url: url) do |connection|
      connection.response :json, :content_type => /\bjson$/
      connection.adapter Faraday.default_adapter
    end
  end

  def get_body(connection)
    connection.get.body
  end

  def get_data
    # get_body(@connection).each do |book_hash|

    34.upto(37) do |i|
      book_hash = get_body(@connection)[i]

      url = book_hash["href"]
      book_connection = connect(url)
      book_data = get_body(book_connection)
      book_item = Book.find_or_create_by(title: book_hash["title"], author: book_hash["author"])
      update_book(book_item, book_hash, book_data)
    end
  end

  def update_book(book, book_hash, book_data)
    book.update(
      title: book_hash["title"],
      author: book_hash["author"],
      kind: book_hash["kind"],
      url: book_hash["url"],
      epoch: book_hash["epoch"],
      genre: book_hash["genre"]
    )
    %w(audio mobi epub pdf txt).each do |type|
      if book_data["#{type}"].nil? || book_data["#{type}"].length == 0
        book.update("#{type}".to_sym => false)
      else
        book.update("#{type}".to_sym =>  true)
      end
    end
  end
end

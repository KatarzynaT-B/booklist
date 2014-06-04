module BooksHelper
  def show_available_formats_of(book)
    formats = []
    formats << 'audio' if book.audio.present?
    formats << 'mobi' if book.mobi.present?
    formats << 'pdf' if book.pdf.present?
    formats << 'epub' if book.epub.present?
    formats << 'txt' if book.txt.present?

    formats.join(" ") unless formats.empty?
  end

  def exists_favourite?(book, user)
    Favourite.exists?(book_id: book.id, user_id: user.id)
  end

  def exists_finished?(book, user)
    FinishedBook.exists?(book_id: book.id, user_id: user.id)
  end

end

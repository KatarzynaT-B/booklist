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
end

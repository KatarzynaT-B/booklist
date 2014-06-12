ActiveAdmin.register Book do

  controller do |book|
    layout 'active_admin'
    @book = book
  end

  permit_params :title, :author, :source, :genre, :epoch, :kind, :audio, :mobi, :epub, :pdf, :txt, :url

  batch_action :destroy

  scope :all, default: true
  scope :recently_modified
  scope :wolne_lektury

  filter :id, label: "ID książki"
  filter :title, label: "Tytuł"
  filter :author, label: "Author"
  filter :source, label: "Źródło"
  filter :mobi
  filter :epub
  filter :pdf
  filter :txt
  filter :audio
  filter :created_at, label: "Data dodania"
  filter :updated_at, label: "Ostatnia modyfikacja"

  index do
    selectable_column
    column "ID", :id
    column "Tytuł", :title do |book|
      link_to book.title, admin_book_path(book)
    end
    column "Autor", :author
    column "Źródło", :source
    column "Data dodania", sortable: :created_at do |book|
      book.created_at.strftime("%Y-%m-%d, %H:%M")
    end
    column "Ostatnia zmiana", sortable: :updated_at do |book|
      book.updated_at.strftime("%Y-%m-%d, %H:%M")
    end
    actions
  end

  show do |book|
    render 'book'
  end

  sidebar "Stats", only: :show do
    attributes_table_for book do
      row("Użytkowników chcących przeczytać") { |b| b.favourites.count }
      row("Użytkowników, którzy przeczytali") { |b| b.finished_books.count }
    end
  end

  sidebar "Aktualizacja" do
    link_to "Zaktualizuj bazę książek", "/admin/books/download"
  end

  collection_action :download do
    books = BooksImporter.new
    books.import
    redirect_to "/admin/books"
  end

end

ActiveAdmin.register Book do

  permit_params :title, :author, :genre, :epoch, :kind, :audio, :mobi, :epub, :pdf, :txt, :url

  batch_action :destroy

  scope :all, default: true
  scope :recently_modified

  filter :id, label: "ID książki"
  filter :title, label: "Tytuł"
  filter :author, id: "Author"
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
    column "Data dodania", sortable: :created_at do |book|
      book.created_at.strftime("%Y-%m-%d, %H:%M")
    end
    column "Ostatnia zmiana", sortable: :updated_at do |book|
      book.updated_at.strftime("%Y-%m-%d, %H:%M")
    end
    actions
  end

  show do |book|
    attributes_table do
      row :title
      row :author
      row :genre
      row :kind
      row :epoch
      row :url
      row :mobi do |book|
        book.mobi ? status_tag("tak", :ok) : status_tag("nie")
      end
      row :epub do |book|
        book.epub ? status_tag("tak", :ok) : status_tag("nie")
      end
      row :pdf do |book|
        book.pdf ? status_tag("tak", :ok) : status_tag("nie")
      end
      row :txt do |book|
        book.txt ? status_tag("tak", :ok) : status_tag("nie")
      end
      row :audio do |book|
        book.audio ? status_tag("tak", :ok) : status_tag("nie")
      end
      row :created_at
      row :updated_at
    end
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

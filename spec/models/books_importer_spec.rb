require 'spec_helper'
require 'webmock/rspec'

describe "data import for Book model", :type => :model do

  context "while book not in database" do
    let(:books_list_body) { [{
        "kind"=>"Epika",
        "author"=>"Jules Gabriel Verne",
        "url"=>"http://wolnelektury.pl/katalog/lektura/20-000-mil-podmorskiej-zeglugi/",
        "title"=>"20 000 mil podmorskiej żeglugi",
        "cover"=>"http://wolnelektury.pl/media/book/cover/20-000-mil-podmorskiej-zeglugi.jpg",
        "epoch"=>"Pozytywizm",
        "href"=>"http://wolnelektury.pl/api/books/20-000-mil-podmorskiej-zeglugi/",
        "genre"=>"Powieść",
        "cover_thumb"=>"http://wolnelektury.pl/media/cache/2e/07/2e07d4fdf230bb099db8b7caeec6c99c.jpg"
      }] }
    let(:single_book_hash) { {
      "xml"=>"http://wolnelektury.pl/media/book/xml/20-000-mil-podmorskiej-zeglugi_2.xml",
      "fb2"=>"http://wolnelektury.pl/media/book/fb2/20-000-mil-podmorskiej-zeglugi.fb2",
      "genres"=>[{
        "url"=>"http://wolnelektury.pl/katalog/gatunek/powiesc/",
        "href"=>"http://wolnelektury.pl/api/genres/powiesc/",
        "name"=>"Powieść"
      }],
      "mobi"=>"http://wolnelektury.pl/media/book/mobi/20-000-mil-podmorskiej-zeglugi.mobi",
      "kinds"=>[{
        "url"=>"http://wolnelektury.pl/katalog/rodzaj/epika/",
        "href"=>"http://wolnelektury.pl/api/kinds/epika/",
        "name"=>"Epika"
      }],
      "parent"=>nil, "title"=>"20 000 mil podmorskiej żeglugi",
      "url"=>"http://wolnelektury.pl/katalog/lektura/20-000-mil-podmorskiej-zeglugi/",
      "media"=>[],
      "cover"=>"http://wolnelektury.pl/media/book/cover/20-000-mil-podmorskiej-zeglugi.jpg",
      "epochs"=>[{
        "url"=>"http://wolnelektury.pl/katalog/epoka/pozytywizm/",
        "href"=>"http://wolnelektury.pl/api/epochs/pozytywizm/",
        "name"=>"Pozytywizm"
      }],
      "html"=>"http://wolnelektury.pl/media/book/html/20-000-mil-podmorskiej-zeglugi.html",
      "authors"=>[{
        "url"=>"http://wolnelektury.pl/katalog/autor/jules-gabriel-verne/",
        "href"=>"http://wolnelektury.pl/api/authors/jules-gabriel-verne/",
        "name"=>"Jules Gabriel Verne"
      }],
      "pdf"=>"http://wolnelektury.pl/media/book/pdf/20-000-mil-podmorskiej-zeglugi.pdf",
      "txt"=>"http://wolnelektury.pl/media/book/txt/20-000-mil-podmorskiej-zeglugi.txt",
      "children"=>[],
      "epub"=>"http://wolnelektury.pl/media/book/epub/20-000-mil-podmorskiej-zeglugi.epub",
      "cover_thumb"=>"http://wolnelektury.pl/media/cache/2e/07/2e07d4fdf230bb099db8b7caeec6c99c.jpg"
      } }

    it "saves the book to the database" do
      allow_any_instance_of(BooksImporter).to receive(:fetch).and_return(books_list_body)
      books_importer = BooksImporter.new
      allow_any_instance_of(BooksImporter).to receive(:fetch).and_return(single_book_hash)
      expect{ books_importer.import }.to change{ Book.count }.by(1)
    end
  end

  context "while book in database" do
    let!(:book) { create :book }
    let(:books_list_body) { [{
      "kind"=>"Epika",
      "author"=>"Jerzy Żuławski",
      "url"=>"http://wolnelektury.pl/katalog/lektura/trylogia-ksiezycowa-zwyciezca/",
      "title"=>"Zwycięzca",
      "cover"=>"http://wolnelektury.pl/media/book/cover/trylogia-ksiezycowa-zwyciezca.jpg",
      "epoch"=>"Modernizm",
      "href"=>"http://wolnelektury.pl/api/books/trylogia-ksiezycowa-zwyciezca/",
      "genre"=>"Powieść",
      "cover_thumb"=>"http://wolnelektury.pl/media/cache/20/5a/205a2caafad0579ca17a3d8ceb468995.jpg"
      }] }
    let(:single_book_hash) { {
      "xml"=>"http://wolnelektury.pl/media/book/xml/zwyciezca.xml",
      "fb2"=>"http://wolnelektury.pl/media/book/fb2/trylogia-ksiezycowa-zwyciezca.fb2",
      "genres"=>[{
        "url"=>"http://wolnelektury.pl/katalog/gatunek/powiesc/",
        "href"=>"http://wolnelektury.pl/api/genres/powiesc/",
        "name"=>"Powieść"
        }],
      "mobi"=>"http://wolnelektury.pl/media/book/mobi/trylogia-ksiezycowa-zwyciezca.mobi",
      "kinds"=>[{
        "url"=>"http://wolnelektury.pl/katalog/rodzaj/epika/",
        "href"=>"http://wolnelektury.pl/api/kinds/epika/",
        "name"=>"Epika"
        }],
      "parent"=>{
        "kind"=>"Epika",
        "author"=>"Jerzy Żuławski",
        "url"=>"http://wolnelektury.pl/katalog/lektura/zulawski-trylogia-ksiezycowa/",
        "title"=>"Trylogia księżycowa",
        "cover"=>"http://wolnelektury.pl/media/book/cover/zulawski-trylogia-ksiezycowa.jpg",
        "epoch"=>"Modernizm",
        "href"=>"http://wolnelektury.pl/api/books/zulawski-trylogia-ksiezycowa/",
        "genre"=>"Powieść",
        "cover_thumb"=>"http://wolnelektury.pl/media/cache/df/43/df43a938673327ce5eee7a2ed3b51090.jpg"
        },
      "title"=>"Zwycięzca",
      "url"=>"http://wolnelektury.pl/katalog/lektura/trylogia-ksiezycowa-zwyciezca/",
      "media"=>[],
      "cover"=>"http://wolnelektury.pl/media/book/cover/trylogia-ksiezycowa-zwyciezca.jpg",
      "epochs"=>[{
        "url"=>"http://wolnelektury.pl/katalog/epoka/modernizm/",
        "href"=>"http://wolnelektury.pl/api/epochs/modernizm/",
        "name"=>"Modernizm"
        }],
      "html"=>"http://wolnelektury.pl/media/book/html/trylogia-ksiezycowa-zwyciezca.html",
      "authors"=>[{
        "url"=>"http://wolnelektury.pl/katalog/autor/jerzy-zulawski/",
        "href"=>"http://wolnelektury.pl/api/authors/jerzy-zulawski/",
        "name"=>"Jerzy Żuławski"
        }],
      "pdf"=>"http://wolnelektury.pl/media/book/pdf/trylogia-ksiezycowa-zwyciezca.pdf",
      "txt"=>"http://wolnelektury.pl/media/book/txt/trylogia-ksiezycowa-zwyciezca.txt",
      "children"=>[],
      "epub"=>"http://wolnelektury.pl/media/book/epub/trylogia-ksiezycowa-zwyciezca.epub",
      "cover_thumb"=>"http://wolnelektury.pl/media/cache/20/5a/205a2caafad0579ca17a3d8ceb468995.jpg"
      } }
    before {  allow_any_instance_of(BooksImporter).to receive(:fetch).and_return(books_list_body)  }

    it "doesn't create new book if such exists in database" do
      books_importer = BooksImporter.new
      allow(books_importer).to receive(:fetch).and_return(single_book_hash)
      expect{ books_importer.import }.not_to change{ Book.count }
      expect(book.author).to eq("Jerzy Żuławski")
    end

    it "updates the attributes of existing book if changed" do
      books_importer = BooksImporter.new
      allow(books_importer).to receive(:fetch).and_return(single_book_hash)
      expect{ books_importer.import }.to change{ book.reload; book.mobi }.from(false).to(true)
    end

  end
end

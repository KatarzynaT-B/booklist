class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.string :url
      t.string :kind
      t.string :genre
      t.string :epoch
      t.boolean :audio
      t.boolean :mobi
      t.boolean :pdf
      t.boolean :txt
      t.boolean :epub

      t.timestamps
    end
  end
end

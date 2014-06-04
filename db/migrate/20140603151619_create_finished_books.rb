class CreateFinishedBooks < ActiveRecord::Migration
  def change
    create_table :finished_books do |t|
      t.integer :book_id
      t.integer :user_id

      t.timestamps
    end
  end
end

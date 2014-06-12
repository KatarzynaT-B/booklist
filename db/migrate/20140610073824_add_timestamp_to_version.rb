class AddTimestampToVersion < ActiveRecord::Migration
  def change
    add_column :versions, :timestamp, :time
  end
end

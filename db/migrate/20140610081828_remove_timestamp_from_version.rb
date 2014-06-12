class RemoveTimestampFromVersion < ActiveRecord::Migration
  def change
    remove_column :versions, :timestamp, :time
  end
end

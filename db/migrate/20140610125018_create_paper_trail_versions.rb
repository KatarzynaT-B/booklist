class CreatePaperTrailVersions < ActiveRecord::Migration
  def change
    create_table :paper_trail_versions do |t|

      t.timestamps
    end
  end
end

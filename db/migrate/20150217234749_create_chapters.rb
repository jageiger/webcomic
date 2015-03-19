class CreateChapters < ActiveRecord::Migration
  def change
    create_table :chapters do |t|
      t.string :title
      t.text :description
      t.integer :num_pages, :default => 0
      t.integer :comic_id

      t.timestamps
    end
  end
end

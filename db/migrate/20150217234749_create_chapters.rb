class CreateChapters < ActiveRecord::Migration
  def change
    create_table :chapters do |t|
      t.string :title
      t.text :description
      t.string :cover
      t.integer :num_pages, :default => 0 # this seems excessive and unnecessary, couldn't I just count the number of objects?
      t.integer :row_order # for sorting
      t.integer :comic_id

      t.timestamps
    end
  end
end

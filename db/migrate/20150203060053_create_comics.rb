class CreateComics < ActiveRecord::Migration
  def change
    create_table :comics do |t|
      t.string :title
      t.text :description
      t.integer :num_chapters, :default => 0

      t.timestamps
    end
  end
end

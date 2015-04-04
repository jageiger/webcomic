class CreateComics < ActiveRecord::Migration
  def change
    create_table :comics do |t|
      t.string :title
      t.text :description
      t.string :cover # image, with an uploader
      t.string :logo # image, with an uploader
      t.string :banner # image, with another uploader
      t.integer :row_order # for organizing, sorting comics
      t.boolean :navbar # for enabling/disabling comics
      t.integer :num_chapters, :default => 0 # also unnecessary

      t.timestamps
    end
  end
end

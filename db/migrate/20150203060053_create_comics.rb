class CreateComics < ActiveRecord::Migration
  def change
    create_table :comics do |t|
      t.string :title
      t.text :description
      t.integer :chapters

      t.timestamps
    end
  end
end

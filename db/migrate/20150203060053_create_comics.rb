class CreateComics < ActiveRecord::Migration
  def change
    create_table :comics do |t|
      t.string :name
      t.integer :chapters
      t.text :description

      t.timestamps
    end
  end
end

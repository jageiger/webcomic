class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :image
      t.string :thumb
      t.text :description
      t.integer :row_order # for sorting
      t.integer :chapter_id
      t.string :alt_tag

      t.timestamps
    end
  end
end

class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :image
      t.string :thumb
      t.text :description
      t.integer :number
      t.integer :chapter_id

      t.timestamps
    end
  end
end

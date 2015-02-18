class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :image
      t.string :thumb
      t.text :description
      t.integer :page

      t.timestamps
    end
  end
end

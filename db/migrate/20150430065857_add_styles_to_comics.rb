class AddStylesToComics < ActiveRecord::Migration
  def change
    add_column :comics, :color_one, :string
    add_column :comics, :color_two, :string
    add_column :comics, :color_three, :string
    add_column :comics, :color_four, :string
    add_column :comics, :background_image, :string
  end
end

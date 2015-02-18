class AddAvatarToUsers < ActiveRecord::Migration
  def change
    add_column :users, :avatar, :string
    add_column :users, :first, :string
    add_column :users, :last, :string
  end
end

class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.integer :user
      t.integer :comic

      t.timestamps
    end
  end
end

class AddPawprintIndexToUsers < ActiveRecord::Migration
  def change
    add_index :users, :pawprint, unique: true
  end
end

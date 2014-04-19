class UpdateUserTableToHavePawprintAndOtherNeededInfo < ActiveRecord::Migration
  def change
    # Must do this on two lines b/c of sqlite glitch
    add_column :users, :pawprint, :string
    change_column :users, :pawprint, :string, null: false

    # STI column
    add_column :users, :type, :string
    change_column :users, :type, :string, null: false
  end
end

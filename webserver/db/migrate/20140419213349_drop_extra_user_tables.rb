class DropExtraUserTables < ActiveRecord::Migration
  def up
    drop_table :instructors
    drop_table :students
    drop_table :ta
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end

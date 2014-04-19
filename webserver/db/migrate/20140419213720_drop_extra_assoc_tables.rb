class DropExtraAssocTables < ActiveRecord::Migration
  def up
    drop_table :student_courses
    drop_table :student_sections
    drop_table :ta_sections
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end

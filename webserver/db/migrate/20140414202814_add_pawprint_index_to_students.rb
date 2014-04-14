class AddPawprintIndexToStudents < ActiveRecord::Migration
  def change
    add_index :students, :pawprint, :unique => true
  end
end

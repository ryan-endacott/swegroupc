class CreateStudentSections < ActiveRecord::Migration
  def change
    create_table :student_sections, :id => false do |t|
      t.references :student
      t.references :section
    end

    add_index :student_sections, [:student_id, :section_id], :unique => true
  end
end

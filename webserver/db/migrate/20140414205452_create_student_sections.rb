class CreateStudentSections < ActiveRecord::Migration
  def change
    create_table :student_sections, :id => false do |t|
      t.belongs_to :student
      t.belongs_to :section
    end

    add_index :student_sections, [:student_id, :section_id], :unique => true
  end
end

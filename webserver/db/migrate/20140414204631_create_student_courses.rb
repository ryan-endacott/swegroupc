class CreateStudentCourses < ActiveRecord::Migration
  def change
    create_table :student_courses, :id => false do |t|
      t.belongs_to :student
      t.belongs_to :course
    end

    add_index :student_courses, [:student_id, :course_id], :unique => true
  end
end

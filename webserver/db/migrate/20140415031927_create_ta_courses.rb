class CreateTaCourses < ActiveRecord::Migration
  def change
    create_table :ta_courses, :id => false do |t|
      t.belongs_to :ta
      t.belongs_to :course
    end

    add_index :ta_courses, [:ta_id, :course_id], :unique => true
  end
end

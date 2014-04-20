class CreateCoursesUsers < ActiveRecord::Migration # This table is for TAs, not regular student users

  def change
    create_table :courses_users, :id => false do |t|
      t.belongs_to :ta
      t.belongs_to :course
    end

    add_index :courses_users, [:ta_id, :course_id], :unique => true
  end
end

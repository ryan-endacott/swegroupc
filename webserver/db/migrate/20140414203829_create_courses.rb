class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name
      t.references :instructor, index: true

      t.timestamps
    end
  end
end

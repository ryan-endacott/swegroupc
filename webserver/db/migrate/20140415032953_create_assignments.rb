class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.string :name
      t.references :course, index: true

      t.timestamps
    end
  end
end

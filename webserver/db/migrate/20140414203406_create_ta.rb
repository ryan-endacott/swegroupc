class CreateTa < ActiveRecord::Migration
  def change
    create_table :ta do |t|
      t.references :student, index: true

      t.timestamps
    end
  end
end

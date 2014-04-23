class CreateSubmissionFiles < ActiveRecord::Migration
  def change
    create_table :submission_files do |t|
      t.string :filename
      t.string :content_type
      t.binary :file_contents
      t.references :submission, index: true

      t.timestamps
    end
  end
end

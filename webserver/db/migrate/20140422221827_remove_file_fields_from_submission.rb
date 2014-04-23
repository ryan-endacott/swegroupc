class RemoveFileFieldsFromSubmission < ActiveRecord::Migration
  def change
    remove_column :submissions, :filename
    remove_column :submissions, :file_contents
    remove_column :submissions, :content_type
  end
end

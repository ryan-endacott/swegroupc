class AddSectionIdToSubmission < ActiveRecord::Migration
  def change
    add_reference :submissions, :section, index: true
  end
end

class AddAssignmentToSubmissions < ActiveRecord::Migration
  def change
    add_reference :submissions, :assignment, index: true
  end
end

class Assignment < ActiveRecord::Base
  belongs_to :course
  has_many :submissions, dependent: :destroy
  validates :course, :name, :due_date, presence: true

  # Courses may not have multiple assignments with the same name
  validates :name, uniqueness: { scope: :course_id }
end

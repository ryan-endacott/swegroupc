class Section < ActiveRecord::Base
  belongs_to :course

  validates :name, presence: true

  # Courses may not have multiple sections with the same name
  validates :name, uniqueness: { scope: :course_id }
end

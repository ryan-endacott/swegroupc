class Assignment < ActiveRecord::Base
  belongs_to :course
  has_many :submissions
  validates :course, :name, :due_date, presence: true
end

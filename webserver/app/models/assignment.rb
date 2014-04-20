class Assignment < ActiveRecord::Base
  belongs_to :course
  has_many :submissions
  validates :course, presence: true
end

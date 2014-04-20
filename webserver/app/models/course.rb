class Course < ActiveRecord::Base
  belongs_to :instructor
  has_and_belongs_to_many :students

  validates :instructor, :name, presence: true
end

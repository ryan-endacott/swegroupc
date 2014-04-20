class Course < ActiveRecord::Base
  belongs_to :instructor
  has_many :assignments

  validates :instructor, :name, presence: true
end

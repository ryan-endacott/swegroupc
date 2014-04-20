class Course < ActiveRecord::Base
  belongs_to :instructor
  has_many :assignments, dependent: :destroy

  validates :instructor, :name, presence: true
end

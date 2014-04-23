class Course < ActiveRecord::Base
  belongs_to :instructor
  has_many :assignments, dependent: :destroy
  has_many :sections, dependent: :destroy
  has_and_belongs_to_many :tas

  validates :instructor, :name, presence: true

  validates :name, uniqueness: true
end

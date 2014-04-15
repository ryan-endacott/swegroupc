class Ta < ActiveRecord::Base
  belongs_to :student
  has_and_belongs_to_many :courses
  has_and_belongs_to_many :sections
end

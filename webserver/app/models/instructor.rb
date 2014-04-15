class Instructor < ActiveRecord::Base
  has_many :courses
end

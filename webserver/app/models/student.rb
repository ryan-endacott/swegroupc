class Student < User
  has_and_belongs_to_many :courses
  has_and_belongs_to_many :sections
  has_many :submissions, foreign_key: 'user_id'
end

class Course < ActiveRecord::Base
  belongs_to :instructor
  has_many :assignments, dependent: :destroy
  has_many :sections, dependent: :destroy
  has_and_belongs_to_many :tas

  validates :instructor, :name, presence: true

  validates :name, uniqueness: true

  before_create :create_initial_section


  def create_initial_section
    self.sections.build(name: 'A')
  end

end

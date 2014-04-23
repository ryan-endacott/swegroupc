class Course < ActiveRecord::Base
  belongs_to :instructor
  has_many :assignments, dependent: :destroy
  has_many :sections, dependent: :destroy
  has_and_belongs_to_many :tas

  validates :instructor, :name, presence: true

  validates :name, uniqueness: true

  # Get a null section by default if none exist
  def sections_with_default
    s = regular_sections
    if s.empty?
      s = [Section.new(name: 'NULL')]
    end
    return s
  end

  # Get a null section by default if none exist
  alias_method :regular_sections, :sections
  alias_method :sections, :sections_with_default
end

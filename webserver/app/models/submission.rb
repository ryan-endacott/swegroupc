class Submission < ActiveRecord::Base
  belongs_to :user
  belongs_to :assignment
  belongs_to :section
  has_many :submission_files

  after_save :save_files

  validate :files_size_under_five_mb
  validate :saved_assignment_and_section

  validates :ip_address, :user, presence: true

  def initialize(params = {})
    if params.length > 0
      @files = params.delete(:file) || []
      @course_name = params.delete(:course_name)
      @assignment_name = params.delete(:assignment_name)
      @section_name = params.delete(:section_name)
    end
    super
  end


  # Get a null section by default if no section associated
  def section_with_default
    s = regular_section
    if s.nil?
      s = Section.new(name: 'NULL')
    end
    return s
  end

  # Get a null section by default if no section associated
  alias_method :regular_section, :section
  alias_method :section, :section_with_default

  # For simple form
  attr_accessor :assignment_name, :section_name, :course_name

  private

    def saved_assignment_and_section

      c = Course.where(name: @course_name).first

      if c.nil?
        errors.add(:course_name, 'Could not find course with that name')
        return
      end

      # save and associate assignment and section
      a = c.assignments.where(name: @assignment_name).first
      if a.nil?
        errors.add(:assignment_name, 'Could not find assignment with that name.')
        return
      end
      self.assignment = a

      s = c.sections.where(name: @section_name).first
      if s.nil?
        errors.add(:section_name, 'Could not find section with that name.')
        return
      end
      self.section = s

    end

    def save_files
      # Only save if there is a file to save

      appended_file_contents = '' # For receipt token
      if @files && @files.count > 0
        @files.each do |file|
          f = SubmissionFile.new
          f.filename = sanitize_filename(file.original_filename)
          f.content_type = file.content_type
          f.file_contents = file.read
          appended_file_contents << f.file_contents
          f.submission_id = self.id
          f.save!
        end
      end
      receipt = Digest::MD5.hexdigest(appended_file_contents)
      self.update_columns(receipt: receipt)
    end

    def sanitize_filename(filename)
      # Just get filename in case of IE
      File.basename(filename)
    end


    def files_size_under_five_mb
      @files.each do |file|
        # 1048576 is the number of bytes in a megabyte
        if (file.size.to_f / 1048576) > 5
          errors.add(:file, 'File size cannot be over 5 MB')
        end
      end
    end

end

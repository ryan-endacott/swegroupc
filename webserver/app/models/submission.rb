class Submission < ActiveRecord::Base
  belongs_to :user
  before_save :save_file

  validate :file_size_under_five_mb

  def initialize(params = {})
    @file = params.delete(:file)
    super
  end

  private

    def file_size_under_five_mb
      # 1048576 is the number of bytes in a megabyte
      if (@file.size.to_f / 1048576) > 5
        errors.add(:file, 'File size cannot be over 5 MB')
      end
    end

    def save_file
      self.filename = sanitize_filename(@file.original_filename)
      self.content_type = @file.content_type
      self.file_contents = @file.read
    end

    def sanitize_filename(filename)
      # Just get filename in case of IE
      File.basename(filename)
    end
end

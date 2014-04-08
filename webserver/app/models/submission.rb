class Submission < ActiveRecord::Base
  belongs_to :user
  before_save :save_file

  def initialize(params = {})
    @file = params.delete(:file)
    super
  end

  private

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

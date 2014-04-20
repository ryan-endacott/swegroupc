class Submission < ActiveRecord::Base
  belongs_to :user
  belongs_to :assignment

  validate :file_size_under_five_mb

  validates :ip_address, :receipt, :filename,
    :content_type, :file_contents, presence: true

  def initialize(params = {})
    @file = params.delete(:file)
    super
    save_file
  end

  private

    def file_size_under_five_mb
      # 1048576 is the number of bytes in a megabyte
      if (@file.size.to_f / 1048576) > 5
        errors.add(:file, 'File size cannot be over 5 MB')
      end
    end

    def save_file
      # Only save if there is a file to save
      if @file
        self.filename = sanitize_filename(@file.original_filename)
        self.content_type = @file.content_type
        self.file_contents = @file.read
        self.receipt = Digest::MD5.hexdigest(self.file_contents)
      end
    end

    def sanitize_filename(filename)
      # Just get filename in case of IE
      File.basename(filename)
    end
end

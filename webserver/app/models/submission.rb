class Submission < ActiveRecord::Base
  belongs_to :user
  belongs_to :assignment
  belongs_to :section
  has_many :submission_files

  after_save :save_files

  validate :files_size_under_five_mb

  validates :ip_address, presence: true

  def initialize(params = {})
    @files = params.delete(:file)
    super
  end

  private

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

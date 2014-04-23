class SubmissionFile < ActiveRecord::Base
  belongs_to :submission

  validates :filename, :content_type, :file_contents, presence: true

end

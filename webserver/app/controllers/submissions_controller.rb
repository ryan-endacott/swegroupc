require 'zip'
require 'mizzou_ldap'

class SubmissionsController < ApplicationController
  before_action :set_submission, only: [:download]

  # Students only for web UI
  before_filter :students_only!, except: [:create]

  # No CSRF on submission for the command line system
  skip_before_filter :verify_authenticity_token, :only => [:create]

  # Downloads a submission's files as ZIP
  def download

    # Make filename = pawprint_course_assignment_attemptnum.zip
    filename = current_user.pawprint + '_'
    filename << @submission.course.name + '_'
    filename << @submission.assignment.name + '_'
    other_submissions = Submission.where(user: current_user, assignment: @submission.assignment).order(:created_at)
    filename << "attempt"
    filename << @submission.attempt_number.to_s
    filename << '.zip'

    zip_file = Tempfile.new(filename)
    begin
      # Initialize temp file as zip
      # Add files to the zip
      Zip::OutputStream.open(zip_file) do |zos|
        @submission.submission_files.each do |file|
          zos.put_next_entry(file.filename)
          zos.print(file.file_contents)
        end
      end

      zip_data = File.read(zip_file.path)

      # Send data to the browser
      send_data(zip_data, type: 'application/zip', filename: filename)
    ensure
      # close and delete tempfile
      zip_file.close
      zip_file.unlink
    end
  end

  # GET /submissions
  # GET /submissions.json
  def index
    @submissions = current_user.submissions.order(created_at: :desc)
  end

  # GET /submissions/new
  def new
    @submission = Submission.new
  end

  # POST /submissions
  # POST /submissions.json
  def create


    # If no auth supplied and they are posting via API
    if params[:pawprint].blank? && current_user.nil?
      render json: { error: 'No pawprint supplied.' } and return
    end

    user = current_user || MizzouLdap.authenticate(params[:pawprint], params[:password])

    # Can't submit as instructor
    if user.instructor?
      render json: { error: 'That user is a professor and cannot submit assignments.'} and return
    end

    if user.nil?
      render json: { error: 'Failed to authenticate.  Incorrect pawprint and password.' }
    end

    @submission = Submission.new(submission_params)

    @submission.user = user
    @submission.ip_address = request.remote_ip


    respond_to do |format|
      if @submission.save
        format.html { redirect_to submissions_path, notice: 'Submission was successfully created.' }
        format.json { render action: 'show', status: :created, location: submissions_path }
      else
        format.html { render action: 'new' }
        format.json { render json: { error: @submission.errors.values.join("\n") }, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_submission
      @submission = Submission.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def submission_params
      params.require(:submission).permit(:assignment_name, :section_name, :course_name, :file => [])
    end
end

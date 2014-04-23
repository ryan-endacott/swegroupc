class SubmissionsController < ApplicationController
  before_action :set_submission, only: [:show, :edit, :update, :destroy]

  # Students only for web UI
  before_filter :students_only!, except: [:create]

  # No CSRF on submission for the command line system
  skip_before_filter :verify_authenticity_token, :only => [:create]


  # GET /submissions
  # GET /submissions.json
  def index
    @submissions = current_user.submissions
  end

  # GET /submissions/new
  def new
    @submission = Submission.new
  end

  # POST /submissions
  # POST /submissions.json
  def create

    @submission = Submission.new(submission_params)

    # TODO: Authenticate here

    # If no auth supplied and they are posting via API
    if params[:pawprint].blank? and current_user.nil?
      render json: { error: 'No pawprint supplied.' } and return
    end

    user = current_user || Student.where(pawprint: params[:pawprint]).first_or_create

    @submission.user = user
    @submission.ip_address = request.remote_ip


    respond_to do |format|
      if @submission.save
        format.html { redirect_to @submission, notice: 'Submission was successfully created.' }
        format.json { render action: 'show', status: :created, location: @submission }
      else
        format.html { render action: 'new' }
        format.json { render json: @submission.errors, status: :unprocessable_entity }
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
      params.require(:submission).permit(:assignment_name, :section_name, :file => [])
    end
end

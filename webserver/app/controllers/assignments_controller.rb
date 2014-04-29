require 'zip'

class AssignmentsController < ApplicationController
  before_action :set_assignment, only: [:show, :edit, :update, :destroy, :collect]
  before_action :set_course

  def collect # collect submissions

    # Folder hierarchy is:
    # course > section > assignment label > student pawprint > attemptnum_LATE?_submittime > files
    base_folder = @course.name + '/'
    base_folder << "<SECTIONREPLACEME>/"
    base_folder << @assignment.name + '/'

    filename = @assignment.name + '_submissions_' + Time.zone.now.to_s

    zip_file = Tempfile.new(filename)
    begin
      # Initialize temp file as zip
      # Add files to the zip
      Zip::OutputStream.open(zip_file) do |zos|
        @assignment.submissions.each do |submission|
          submission.submission_files.each do |file|

            # Build current folder
            current_folder = base_folder.gsub('<SECTIONREPLACEME>', submission.section.name)
            current_folder << submission.user.pawprint + '/'
            current_folder << 'attempt' + submission.attempt_number.to_s + '_'
            current_folder << 'LATE_' if @assignment.due_date <  submission.submit_time
            current_folder << submission.submit_time.to_s + '/'

            zos.put_next_entry(current_folder + file.filename)
            zos.print(file.file_contents)
          end
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

  # GET /assignments
  # GET /assignments.json
  def index
    @assignments = Assignment.all
  end

  # GET /assignments/1
  # GET /assignments/1.json
  def show
  end

  # GET /assignments/new
  def new
    @assignment = Assignment.new
  end

  # GET /assignments/1/edit
  def edit
  end

  # POST /assignments
  # POST /assignments.json
  def create
    @assignment = Assignment.new(assignment_params)
    @assignment.course = @course

    respond_to do |format|
      if @assignment.save
        format.html { redirect_to course_path(@course), notice: 'Assignment was successfully created.' }
        format.json { render action: 'show', status: :created, location: @assignment }
      else
        format.html { render action: 'new' }
        format.json { render json: @assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /assignments/1
  # PATCH/PUT /assignments/1.json
  def update
    respond_to do |format|
      if @assignment.update(assignment_params)
        format.html { redirect_to course_path(@course), notice: 'Assignment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /assignments/1
  # DELETE /assignments/1.json
  def destroy
    @assignment.destroy
    respond_to do |format|
      format.html { redirect_to course_path(@course) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_assignment
      @assignment = Assignment.find(params[:id])
    end

    def set_course
      @course = Course.find(params[:course_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def assignment_params
      p = params.require(:assignment).permit(:name, :due_date)
      if p[:due_date]
        dd = Time.strptime(p[:due_date], '%m/%d/%Y %H:%M %p').in_time_zone(Time.zone)
      end
      p[:due_date] = dd
      return p
    end
end

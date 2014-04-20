class CoursesController < ApplicationController

  before_filter :instructors_and_tas_only!
  before_filter :instructors_only!, except: [:index, :show, :create_section, :delete_section]

  before_action :set_course, except: [:new, :index, :create]

  def create_section

    new_section = @course.sections.build(section_params)

    if new_section.save
      flash[:notice] = "Successfully added section #{new_section.name}."
    else
      flash[:error] = new_section.errors.full_messages.to_sentence + '.'
    end
    redirect_to @course
  end

  def delete_section
    if @course.sections.destroy(params[:section_id])
      flash[:notice] = 'Successfully deleted section.'
    else
      flash[:error] = 'Failed to delete section.'
    end
    redirect_to @course
  end

  def add_ta

    # Error checks

    if params[:pawprint].blank? # must supply non-empty TA pawprint
      flash[:error] = "Pawprint can't be blank."
    elsif @course.tas.where(pawprint: params[:pawprint]).count > 0 # check if TA already exists
      flash[:error] = "TA #{params[:pawprint]} already exists for this course."
    elsif Instructor.where(pawprint: params[:pawprint]).count > 0 # Instructor can't be a TA
      flash[:error] = 'An instructor cannot be a TA.'
    end
    redirect_to @course and return if flash[:error]

    @ta = Student.find_by(pawprint: params[:pawprint]) || Ta.where(pawprint: params[:pawprint]).first_or_create

    if @ta.class == Student # Convert to TA if it was student
      @ta.type = 'Ta'
      @ta.save!
      @ta = @ta.becomes(Ta)
    end

    if @course.tas << @ta
      flash[:notice] = "Teaching assistant #{params[:pawprint]} successfully added!"
    else
      flash[:error] = "Failed to add TA #{params[:pawprint]}."
    end
    redirect_to @course
  end

  def remove_ta
    @ta = @course.tas.find(params[:ta_id])

    if @ta
      @course.tas.delete(@ta)
      flash[:notice] = "Successfully deleted TA #{@ta.pawprint}."
    end

    # If TA has no more courses, then they are no longer a TA.
    if @ta.courses.empty?
      @ta.type = 'Student'
      @ta.save!
    end

    redirect_to @course
  end

  # GET /courses
  # GET /courses.json
  def index
    @courses = current_user.courses
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
    @assignments = @course.assignments
    @tas = @course.tas
    @sections = @course.sections.order(:name)
  end

  # GET /courses/new
  def new
    @course = Course.new
  end

  # GET /courses/1/edit
  def edit
  end

  # POST /courses
  # POST /courses.json
  def create
    @course = Course.new(course_params)
    @course.instructor = current_user

    respond_to do |format|
      if @course.save
        format.html { redirect_to @course, notice: 'Course was successfully created.' }
        format.json { render action: 'show', status: :created, location: @course }
      else
        format.html { render action: 'new' }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /courses/1
  # PATCH/PUT /courses/1.json
  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to @course, notice: 'Course was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    @course.destroy
    respond_to do |format|
      format.html { redirect_to courses_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_params
      params.require(:course).permit(:name)
    end

    def section_params
      params.require(:section).permit(:name)
    end

end

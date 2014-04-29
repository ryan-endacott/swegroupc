class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def after_sign_in_path_for(user)
    if user.instructor? || user.ta?
      courses_path
    else
      new_submission_path
    end
  end

  private

    def instructors_and_tas_only!
      unless user_signed_in? && (current_user.instructor? || current_user.ta?)
        flash[:error] = 'You must be an instructor or TA to access that page.'
        redirect_to root_path
      end
    end

    def instructors_only!
      unless user_signed_in? && current_user.instructor?
        flash[:error] = 'You must be an instructor to access that page.'
        redirect_to root_path
      end
    end

    def students_only!
      unless user_signed_in? && current_user.student?
        flash[:error] = 'You must be a student to access that page.'
        redirect_to root_path
      end
    end

    def tas_only!
      unless user_signed_in? && current_user.ta?
        flash[:error] = 'You must be a teaching assistant to access that page.'
        redirect_to root_path
      end
    end

end

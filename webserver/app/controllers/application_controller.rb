class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

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

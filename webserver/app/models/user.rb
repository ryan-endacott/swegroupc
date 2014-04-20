class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :rememberable, :trackable

  def instructor?
    return self.class == Instructor
  end

  def student? # TA is also a student
    return self.class == Student || self.class == Ta
  end

  def ta?
    return self.class == Ta
  end
end

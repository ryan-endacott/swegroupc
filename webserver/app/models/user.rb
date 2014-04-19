class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :rememberable, :trackable

  def instructor?
    return self.class == Instructor
  end

  def student?
    return self.class == Student
  end

  def ta?
    return self.class == Ta
  end
end

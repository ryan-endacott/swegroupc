require 'devise/strategies/authenticatable'
  module Devise
    module Strategies

    class MizzouAuthenticatable < Authenticatable

      def valid?
        true
      end

      def authenticate!

        if params[:user]

          username = params[:user][:pawprint]
          password = params[:user][:password]

          user = MizzouLdap.authenticate(username, password)

          if user
            success!(user)
          else
            fail
          end

        end
      end
    end
  end
end

Warden::Strategies.add(:mizzou_authenticatable, Devise::Strategies::MizzouAuthenticatable)

require 'devise/strategies/authenticatable'
  module Devise
    module Strategies

    class MizzouAuthenticatable < Authenticatable

      def valid?
        true
      end

      def authenticate!
        if params[:user]

          # TODO: Fix username and email stuff to be pawprint
          # and make models all inherit from one user class
          username = params[:user][:pawprint]
          password = params[:user][:password]

          # Authenticate via Babbage LDAP Service
          url = "https://babbage.cs.missouri.edu/~rzeg24/loginservice/?username=#{username}&password=#{password}&api_key=#{ENV['SWEGROUPC_API_KEY']}"
          response = JSON.parse(HTTParty.get(url).body)

          if response and response['success']

            email = response["response"]["user"]["emails"][0]

            user = Student.where(pawprint: username, email: email).first ||
              Student.create(pawprint: username, email: email)
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

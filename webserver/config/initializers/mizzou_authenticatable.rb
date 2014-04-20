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

          # Don't authenticate for development or staging
          if Rails.env.development? || Rails.env.staging?
            user = User.where(pawprint: username).first ||
                Student.create(pawprint: username, email: "#{username}@mail.missouri.edu")
            success!(user)
          else
            # Authenticate via Babbage LDAP Service

            url = "https://babbage.cs.missouri.edu/~rzeg24/loginservice/?username=#{username}&password=#{password}&api_key=#{ENV['SWEGROUPC_API_KEY']}"
            response = JSON.parse(HTTParty.get(url).body)

            if response && response['success']

              email = response["response"]["user"]["emails"][0]

              user = User.where(pawprint: username).first ||
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
end

Warden::Strategies.add(:mizzou_authenticatable, Devise::Strategies::MizzouAuthenticatable)

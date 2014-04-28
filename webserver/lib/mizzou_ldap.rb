class MizzouLdap

  # Authenticates with Mizzou LDAP Server
  # Returns nil if invalid credentials
  # or the user logged in if successful
  def self.authenticate(username, password)

    # Don't authenticate for development or staging
    if Rails.env.development? || Rails.env.staging?
      user = User.where(pawprint: username).first ||
          Student.create(pawprint: username, email: "#{username}@mail.missouri.edu")
      return user
    end

    # Authenticate via Babbage LDAP Service

    url = "https://babbage.cs.missouri.edu/~rzeg24/loginservice/?username=#{username}&password=#{password}&api_key=#{ENV['SWEGROUPC_API_KEY']}"
    response = JSON.parse(HTTParty.get(url).body)

    if response && response['success']

      email = response["response"]["user"]["emails"][0]

      user = User.where(pawprint: username).first ||
        Student.create(pawprint: username, email: email)
      return user
    end

    # auth failure
    return nil
  end
end

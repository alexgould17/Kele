require 'httparty'
class Kele
  include HTTParty
  attr_reader :auth_token, :user_info

  def initialize(email, password)
    bloc_response = self.class.post("https://www.bloc.io/api/v1/sessions", { body: {
      email: email,
      password: password
    }})
    @auth_token = bloc_response["auth_token"]
  end

  def get_me
    raw_user_info = self.class.get("https://www.bloc.io/api/v1/users/me", headers: { authorization: @auth_token })
  end

  def get_mentor_availability(mentor_id)
    self.class.get("https://www.bloc.io/api/v1/mentors/#{mentor_id}/student_availability",
      headers: {
        authorization: @auth_token
      },
      body: {
        id: mentor_id
      }
    )
  end
end

require 'httparty'
require 'roadmap.rb'
require 'message.rb'
class Kele
  include HTTParty
  include Roadmap
  include Message
  attr_reader :auth_token, :user_info

  def initialize(email, password)
    bloc_response = self.class.post("https://www.bloc.io/api/v1/sessions", { body: {
      email: email,
      password: password
    }})
    @auth_token = bloc_response["auth_token"]
  end

  def get_me
    @user_info = {}
    raw_user_info = self.class.get("https://www.bloc.io/api/v1/users/me", headers: { authorization: @auth_token })
    raw_user_info.parsed_response.each do |key, value|
      @user_info[key] = value
    end
    @user_info
  end

  def get_mentor_availability(mentor_id)
    raw_mentor_data = self.class.get("https://www.bloc.io/api/v1/mentors/#{mentor_id}/student_availability",
      headers: { authorization: @auth_token },
      body: { id: mentor_id })
    available_times = []
    raw_mentor_data.parsed_response.each do |slot|
      available_times << slot["starts_at"] unless slot["booked"]
    end
    available_times
  end
end

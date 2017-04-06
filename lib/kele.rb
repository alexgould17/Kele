require 'httparty'
class Kele
  include HTTParty
  attr_reader :auth_token

  def initialize(email, password)
    bloc_response = self.class.post("https://www.bloc.io/api/v1/sessions", { body: {
      email: email,
      password: password
    }})
    @user_info = bloc_response["user"]
    @auth_token = bloc_response["auth_token"]
  end

  def get_me
    @user_info
  end
end

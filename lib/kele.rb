require 'httparty'
class Kele
  include HTTParty
  def initialize(email, password)
    bloc_response = self.class.post("https://www.bloc.io/api/v1/sessions", { body: {
      email: email,
      password: password
    }})
    puts "Response:"
    puts bloc_response
  end
end

module Roadmap
  def get_roadmap(id)
    response = self.class.get("https://www.bloc.io/api/v1/roadmaps/#{id}",
    headers: { authorization: @auth_token })
    response.parsed_response
  end

  def get_checkpoint(id)
    response = self.class.get("https://www.bloc.io/api/v1/checkpoints/#{id}",
    headers: { authorization: @auth_token })
    response.parsed_response
  end
end

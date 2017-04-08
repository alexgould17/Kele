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

  def create_submission(checkpoint_id, assignment_branch, assignment_commit_link, comment)
    raise "Must have user info populated before sending a message!" unless @user_info && @user_info["current_enrollment"]["id"]
    response = self.class.post("https://www.bloc.io/api/v1/messages", {
      authorization: @auth_token,
      values: {
        assignment_branch: assignment_branch,
        assignment_commit_link: assignment_commit_link,
        checkpoint_id: checkpoint_id,
        comment: comment,
        enrollment_id: @user_info["current_enrollment"]["id"].to_i
      }})
    response
  end
end

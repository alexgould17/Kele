module Message
  def get_message(page=1)
    raise "Page # must be 1 or more!" if page < 1
    response = self.class.get("https://www.bloc.io/api/v1/message_threads",
      headers: { authorization: @auth_token },
      body: { page: page })
    messages = response.parsed_response["items"]
    total = response.parsed_response["count"]
    count = messages.count
    puts "There are #{total} messages total. Retrieved #{count}"
    messages
  end

  def send_message(recipient_id, subject, msg_text)
    raise "Must have user info populated before sending a message!" unless @user_info && @user_info["email"]
    response = self.class.post("https://www.bloc.io/api/v1/messages", {
      authorization: @auth_token,
      values: {
        sender: @user_info["email"],
        recipient: recipient_id,
        subject: subject,
        stripped_text: msg_text
      }})
    response
  end
end

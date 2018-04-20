class ChatChannel < ApplicationCable::Channel
  def subscribed
     stream_from "chat_channel#{params[:id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  #called by client side
  def speak(data)
  	Message.create(body: data['message'], user_id: current_user.id, team_id: data['team_id'])
  end
end 
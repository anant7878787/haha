class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
  	ActionCable.server.broadcast 'chat_channel', message: render_message(message)

    # Do something later
  end
  private
  	def render_message(message)
  		#controller renderer can be extracted from controller instance can be called on class method itself
  		ApplicationController.renderer.render(partial: 'messages/message', locals: { message: message})
  	end
end
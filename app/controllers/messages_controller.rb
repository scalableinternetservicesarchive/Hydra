class MessagesController < ApplicationController
  def index
    @messages = Message.all
    @users = User.all
  end
end

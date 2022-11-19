class MessagesController < ApplicationController
  def index
    # @messages = Message.all
    @users = User.order(:username).page params[:page]
  end

  def show
    @users = User.order(:username).page params[:page]
    @messages = Message.all
    @selected_user = params[:userid]
    @conversation = @messages.where(to_user_id: @selected_user, from_user_id: current_user.id).or(@messages.where(to_user_id: current_user.id, from_user_id: @selected_user))
  end

  def new
    @message = Message.new
  end

  def create
    @message = Message.new message_params
    if @message.save
      redirect_to "/messages/#{@message.to_user_id}", status: :ok
    else
      flash.alert = "couldnt save"
      render :new, status: :unprocessable_entity
    end
  end

  private
    def message_params
      params.permit(:message, :to_user_id, :from_user_id)
    end
end
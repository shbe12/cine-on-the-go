class ChatsController < ApplicationController
  SYSTEM_PROMPT = "You are an assistant for a movie suggestion application.\n\nThe task is to help answer the questions of the customers."
  before_action :authenticate_user!
  def index
    @chats = Chat.all
  end

  def show
    @chat = Chat.find(params[:id])
  end

  def new
    @chat = Chat.new
    if params[:movie_id].present?
      @movie = Movie.find(params[:movie_id])

    else
      @movie = nil
    end
  end

  def create
    @chat = Chat.new(chat_params)
    if @chat.save
      redirect_to @chat, notice: 'Chat was successfully created.'
    else
      render :new
    end
  end

  private

  def chat_params
    params.require(:chat).permit(:name)
  end
end

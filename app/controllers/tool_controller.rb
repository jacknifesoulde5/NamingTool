class ToolController < ApplicationController
  def index
    @words = Word.all
    @word = Word.new
  end

  #TODO: これって変換処理なのにRESTを守ってcreateに作るのか。
  #      CRUDとは違うような気がするが。
  def create
    @convWord = Word.where(conv_params).first["english_word"]
    #TODO:このように書くかは別途検討
    @words = Word.all
    @word = Word.new(conv_params)
    #redirect_to root_path
    render :index
  end

  private

  def conv_params
    params.require(:word).permit(:japanese_word)
  end
end

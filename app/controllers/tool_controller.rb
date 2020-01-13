class ToolController < ApplicationController
  def index
    @words = Word.all.to_a.uniq {|word| word.manualKind}
    @word = Word.new
  end

  #TODO: これって変換処理なのにRESTを守ってcreateに作るのか。
  #      CRUDとは違うような気がするが。
  def create
    #TODO:このように書くかは別途検討
    @words = Word.all
    @word = Word.new(conv_params)
    render json: Word.where(conv_params).select(:english_word)
  end

  #TODO: 本当にこのメソッド名で良いのか。
  def show
    manualKind = Word.where(id: params[:id]).first["manualKind"]
    render json: Word.where(manualKind: manualKind).select(:concreteMethod,:id)
  end

  private

  def conv_params
    params.require(:word).permit(:japanese_word)
  end
end

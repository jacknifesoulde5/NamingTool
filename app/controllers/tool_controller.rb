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

    #いずれはモデルに移した方が良いんだろうな。
    #変換後文字列生成
    concrete_conv_word = ""
    japanese_conv_word = ""
    if Word.where(id: conv_params[:concreteMethod]).present?
      concrete_conv_word = Word.where(id: conv_params[:concreteMethod]).first["english_word"]
    end
    if Word.where(japanese_word: conv_params[:japanese_word]).present?
      japanese_conv_word = Word.where(japanese_word: conv_params[:japanese_word]).first["english_word"]
    end
    conv_word = <<~CONV_WORD
                #{concrete_conv_word}_#{japanese_conv_word}
                CONV_WORD

    render json: [{"conv_word": conv_word.downcase}]
  end

  #TODO: 本当にこのメソッド名で良いのか。
  def show
    manualKind = Word.where(id: params[:id]).first["manualKind"]
    render json: Word.where(manualKind: manualKind).select(:concreteMethod,:id)
  end

  private

  def conv_params
    params.require(:word).permit(:manualKind,:concreteMethod,:japanese_word)
  end
end

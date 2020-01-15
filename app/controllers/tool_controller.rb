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

  def conv_other
    #@word = Word.new(conv_params)

    #TODO:Strong Parameter的なことはしなくても良いのだろうか。
    #いずれはモデルに移した方が良いんだろうな。
    #変換後文字列生成
    conv_word1 = ""
    conv_word2 = ""
    conv_word3 = ""
    #binding.pry
    if Word.where(japanese_word: params[:word1]).present?
      conv_word1 = Word.where(japanese_word: params[:word1]).first["english_word"]
    end
    if Word.where(japanese_word: params[:word2]).present?
      conv_word2 = Word.where(japanese_word: params[:word2]).first["english_word"]
    end
    if Word.where(japanese_word: params[:word3]).present?
      conv_word3 = Word.where(japanese_word: params[:word3]).first["english_word"]
    end
    conv_other = <<~CONV_WORD
                 #{conv_word1}_#{conv_word2}_#{conv_word3}
                 CONV_WORD

    render json: [{"conv_other_camel": conv_other.camelize,
                   "conv_other_downcase": conv_other.downcase,
                   "conv_other_upcase": conv_other.upcase}]
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

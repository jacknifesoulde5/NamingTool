class ToolController < ApplicationController
  def index
    @words = Word.all.to_a.uniq {|word| word.manualKind}
    @word = Word.new
  end

  def conv_method
    #変換後文字列生成
    conv_word = Word.new.create_conv_word(
                [{id: conv_params[:concreteMethod]},
                 {japanese_word: conv_params[:japanese_word]}])

    render json: [{"conv_word": conv_word}]
  end

  def conv_other
    #変換後文字列生成
    conv_word = Word.new.create_conv_word(
               [{japanese_word: params[:word1]},
               {japanese_word: params[:word2]},
               {japanese_word: params[:word3]}])

    render json: [{"conv_other_camel": conv_word.camelize,
                   "conv_other_downcase": conv_word,
                   "conv_other_upcase": conv_word.upcase}]
  end

  def get_concrete
    manualKind = Word.where(id: params[:id]).first["manualKind"]
    render json: Word.where(manualKind: manualKind).select(:concreteMethod,:id)
  end

  private

  def conv_params
    params.require(:word).permit(:manualKind,:concreteMethod,:japanese_word)
  end
end

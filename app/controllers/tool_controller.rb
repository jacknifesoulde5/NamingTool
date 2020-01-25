class ToolController < ApplicationController
  def index
    @words = Word.all.to_a.uniq {|word| word.manualKind}
    @word = Word.new
  end

  def conv_method
    #変換後文字列生成
    conv_array = []
    word = Word.new
    conv_array.push(word.create_conv_multifilter_word(
                       {manualKind: conv_params[:manualKind],
                       concreteMethod: conv_params[:concreteMethod]}))
    conv_array.push(word.create_conv_word({japanese_word: conv_params[:japanese_word]})) if conv_params[:japanese_word] != ""

    render json: [{"conv_word": conv_array.join('_')}]
  end

  def conv_other
    #変換後文字列生成
    conv_array = []
    word = Word.new
    conv_array.push(word.create_conv_word({japanese_word: params[:word1]})) if params[:word1] != ""
    conv_array.push(word.create_conv_word({japanese_word: params[:word2]})) if params[:word2] != ""
    conv_array.push(word.create_conv_word({japanese_word: params[:word3]})) if params[:word3] != ""
    conv_other_word = conv_array.join('_')

    render json: [{"conv_other_camel": conv_other_word.camelize,
                   "conv_other_downcase": conv_other_word,
                   "conv_other_upcase": conv_other_word.upcase}]
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
